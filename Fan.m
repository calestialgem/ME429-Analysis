classdef Fan
    properties
        Name
        m
        D
        I
        Ct
        Cq
        w_min
        w_max
        w_J_data
        Ct_data
        Cq_data
        Ct_rms
        Cq_rms
    end
    methods
        function self = Fan(name, m, D, w_min, w_max, w_J_data, Ct_data, Cq_data)
            self.Name = name;
            self.m = m;
            self.D = D;
            self.I = self.m * self.D^2/12;
            self.Ct = fit(w_J_data, Ct_data, 'poly55', 'Normalize', 'on');
            self.Cq = fit(w_J_data, Cq_data, 'poly55', 'Normalize', 'on');
            self.w_min = w_min;
            self.w_max = w_max;
            self.w_J_data = w_J_data;
            self.Ct_data = Ct_data;
            self.Cq_data = Cq_data;
            self.Ct_rms = sqrt(sum((self.Ct(w_J_data) - Ct_data).^2) / size(w_J_data, 1)) / (max(Ct_data) - min(Ct_data));
            self.Cq_rms = sqrt(sum((self.Cq(w_J_data) - Cq_data).^2) / size(w_J_data, 1)) / (max(Cq_data) - min(Cq_data));
        end
        function [T, Q] = Find(self, air, V, w)
            J = V ./ (w .* self.D);
            T = (air.R * self.D^4) * w.^2 .* self.Ct(w, J);
            Q = (air.R * self.D^5) * w.^2 .* self.Cq(w, J);
        end
        function RMS = RootMeanSquare(self)
            RMS = sprintf('Root Mean Squares Ct=%.2f%%%% Cq=%.2f%%%%\n', self.Ct_rms * 100, self.Cq_rms * 100);
        end
        function PlotFitJ(self)
            J_data = reshape(self.w_J_data(:, 2), [], 17);
            J_data = J_data(:, 1);
            w_data = reshape(self.w_J_data(:, 1), [], 17);
            w_data = w_data(1, :);
            Ct_data = reshape(self.Ct_data, [], 17)';
            Cq_data = reshape(self.Cq_data, [], 17)';
            J_range = 0:J_data(end) / 100:J_data(end);
            w_middle = ceil(length(w_data) / 2);
            figure();
            title(self.Name + " Thrust Coefficient vs J");
            hold('on');
            grid('on');
            xlabel('J');
            ylabel('c_t');
            plot(J_range, self.Ct(w_data(1), J_range), '-r', 'LineWidth', 2);
            plot(J_range, self.Ct(w_data(w_middle), J_range), '-g', 'LineWidth', 2);
            plot(J_range, self.Ct(w_data(end), J_range), '-b', 'LineWidth', 2);
            plot(J_data, Ct_data(1, :), 'xr', 'LineWidth', 2);
            plot(J_data, Ct_data(w_middle, :), 'xg', 'LineWidth', 2);
            plot(J_data, Ct_data(end, :), 'xb', 'LineWidth', 2);
            legend( ...
                sprintf('Fit w=%.0frad/s', w_data(1)), ...
                sprintf('Fit w=%.0frad/s', w_data(w_middle)), ...
                sprintf('Fit w=%.0frad/s', w_data(end)), ...
                sprintf('Data w=%.0frad/s', w_data(1)), ...
                sprintf('Data w=%.0frad/s', w_data(w_middle)), ...
                sprintf('Data w=%.0frad/s', w_data(end)), 'Location', 'Best');
            saveas(gcf, 'Thrust Coefficient vs Advance Ratio', 'jpeg');
            figure();
            title(self.Name + " Torque Coefficient vs J");
            hold('on');
            grid('on');
            xlabel('J');
            ylabel('c_q');
            plot(J_range, self.Cq(w_data(1), J_range), '-r', 'LineWidth', 2);
            plot(J_range, self.Cq(w_data(w_middle), J_range), '-g', 'LineWidth', 2);
            plot(J_range, self.Cq(w_data(end), J_range), '-b', 'LineWidth', 2);
            plot(J_data, Cq_data(1, :), 'xr', 'LineWidth', 2);
            plot(J_data, Cq_data(w_middle, :), 'xg', 'LineWidth', 2);
            plot(J_data, Cq_data(end, :), 'xb', 'LineWidth', 2);
            legend( ...
                sprintf('Fit w=%.0frad/s', w_data(1)), ...
                sprintf('Fit w=%.0frad/s', w_data(w_middle)), ...
                sprintf('Fit w=%.0frad/s', w_data(end)), ...
                sprintf('Data w=%.0frad/s', w_data(1)), ...
                sprintf('Data w=%.0frad/s', w_data(w_middle)), ...
                sprintf('Data w=%.0frad/s', w_data(end)), 'Location', 'Best');
            saveas(gcf, 'Torque Coefficient vs Advance Ratio', 'jpeg');
        end
        function PlotFitw(self)
            J_data = reshape(self.w_J_data(:, 2), [], 17);
            J_data = J_data(:, 1);
            w_data = reshape(self.w_J_data(:, 1), [], 17);
            w_data = w_data(1, :);
            Ct_data = reshape(self.Ct_data, [], 17)';
            Cq_data = reshape(self.Cq_data, [], 17)';
            w_range = 0:w_data(end) / 100:w_data(end);
            J_middle = ceil(length(J_data) / 2);
            figure();
            title(self.Name + " Thrust Coefficient vs w");
            hold('on');
            grid('on');
            xlabel('w (rad/s)');
            ylabel('c_t');
            plot(w_range, self.Ct(w_range, J_data(1)), '-r', 'LineWidth', 2);
            plot(w_range, self.Ct(w_range, J_data(J_middle)), '-g', 'LineWidth', 2);
            plot(w_range, self.Ct(w_range, J_data(end)), '-b', 'LineWidth', 2);
            plot(w_data, Ct_data(:, 1), 'xr', 'LineWidth', 2);
            plot(w_data, Ct_data(:, J_middle), 'xg', 'LineWidth', 2);
            plot(w_data, Ct_data(:, end), 'xb', 'LineWidth', 2);
            legend( ...
                sprintf('Fit J=%.2f', J_data(1)), ...
                sprintf('Fit J=%.2f', J_data(J_middle)), ...
                sprintf('Fit J=%.2f', J_data(end)), ...
                sprintf('Data J=%.2f', J_data(1)), ...
                sprintf('Data J=%.2f', J_data(J_middle)), ...
                sprintf('Data J=%.2f', J_data(end)), 'Location', 'Best');
            saveas(gcf, 'Thrust Coefficient vs Angular Speed', 'jpeg');
            figure();
            title(self.Name + " Torque Coefficient vs w");
            hold('on');
            grid('on');
            xlabel('w (rad/s)');
            ylabel('c_q');
            plot(w_range, self.Cq(w_range, J_data(1)), '-r', 'LineWidth', 2);
            plot(w_range, self.Cq(w_range, J_data(J_middle)), '-g', 'LineWidth', 2);
            plot(w_range, self.Cq(w_range, J_data(end)), '-b', 'LineWidth', 2);
            plot(w_data, Cq_data(:, 1), 'xr', 'LineWidth', 2);
            plot(w_data, Cq_data(:, J_middle), 'xg', 'LineWidth', 2);
            plot(w_data, Cq_data(:, end), 'xb', 'LineWidth', 2);
            legend( ...
                sprintf('Fit J=%.2f', J_data(1)), ...
                sprintf('Fit J=%.2f', J_data(J_middle)), ...
                sprintf('Fit J=%.2f', J_data(end)), ...
                sprintf('Data J=%.2f', J_data(1)), ...
                sprintf('Data J=%.2f', J_data(J_middle)), ...
                sprintf('Data J=%.2f', J_data(end)), 'Location', 'Best');
            saveas(gcf, 'Torque Coefficient vs Angular Speed', 'jpeg');
        end
    end
end
