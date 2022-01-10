classdef Fan
	properties
		Name
		m
		D
		I
		T
		Q
		w_min
		w_max
		w_J_data
		T_data
		Q_data
		T_rms
		Q_rms
	end
	methods
		function self = Fan(name, m, D, w_min, w_max, w_J_data, T_data, Q_data)
			self.Name = name;
			self.m = m;
			self.D = D;
			self.I = self.m*self.D^2/12;
			self.T = fit(w_J_data, T_data, 'poly55', 'Normalize', 'on');
			self.Q = fit(w_J_data, Q_data, 'poly55', 'Normalize', 'on');
			self.w_min = w_min;
			self.w_max = w_max;
			self.w_J_data = w_J_data;
			self.T_data = T_data;
			self.Q_data = Q_data;
			self.T_rms = sqrt(sum((self.T(w_J_data)-T_data).^2))/size(w_J_data, 1)/(max(T_data)-min(T_data));
			self.Q_rms = sqrt(sum((self.Q(w_J_data)-Q_data).^2))/size(w_J_data, 1)/(max(Q_data)-min(Q_data));
		end
		function [T, Q] = Find(self, V, w)
			J = V./(w.*self.D);
			T = self.T(w, J);
			Q = self.Q(w, J);
		end
		function RMS = RootMeanSquare(self)
			RMS = sprintf('Root Mean Squares T=%e Q=%e\n', self.T_rms, self.Q_rms);
		end
		function PlotFitJ(self)
			J_data = reshape(self.w_J_data(:, 2), [], 17);
			J_data = J_data(:, 1);
			w_data = reshape(self.w_J_data(:, 1), [], 17);
			w_data = w_data(1, :);
			T_data = reshape(self.T_data, [], 17)';
			Q_data = reshape(self.Q_data, [], 17)';
			J_range = 0:J_data(end)/100:J_data(end);
			w_middle = ceil(length(w_data)/2);
			figure();
			title(self.Name + " Thrust vs J");
			hold('on');
			grid('on');
			xlabel('J');
			ylabel('T (N)');
			plot(J_range, self.T(w_data(1), J_range), '-r', 'LineWidth', 2);
			plot(J_range, self.T(w_data(w_middle), J_range), '-g', 'LineWidth', 2);
			plot(J_range, self.T(w_data(end), J_range), '-b', 'LineWidth', 2);
			plot(J_data, T_data(1, :), 'xr', 'LineWidth', 2);
			plot(J_data, T_data(w_middle, :), 'xg', 'LineWidth', 2);
			plot(J_data, T_data(end, :), 'xb', 'LineWidth', 2);
			legend(...
				sprintf('Fit w=%.0frad/s', w_data(1)),...
				sprintf('Fit w=%.0frad/s', w_data(w_middle)),...
				sprintf('Fit w=%.0frad/s', w_data(end)),...
				sprintf('Data w=%.0frad/s', w_data(1)),...
				sprintf('Data w=%.0frad/s', w_data(w_middle)),...
				sprintf('Data w=%.0frad/s', w_data(end)), 'Location', 'Best');
			figure();
			title(self.Name + " Torque vs J");
			hold('on');
			grid('on');
			xlabel('J');
			ylabel('Q (N.m)');
			plot(J_range, self.Q(w_data(1), J_range), '-r', 'LineWidth', 2);
			plot(J_range, self.Q(w_data(w_middle), J_range), '-g', 'LineWidth', 2);
			plot(J_range, self.Q(w_data(end), J_range), '-b', 'LineWidth', 2);
			plot(J_data, Q_data(1, :), 'xr', 'LineWidth', 2);
			plot(J_data, Q_data(w_middle, :), 'xg', 'LineWidth', 2);
			plot(J_data, Q_data(end, :), 'xb', 'LineWidth', 2);
			legend(...
				sprintf('Fit w=%.0frad/s', w_data(1)),...
				sprintf('Fit w=%.0frad/s', w_data(w_middle)),...
				sprintf('Fit w=%.0frad/s', w_data(end)),...
				sprintf('Data w=%.0frad/s', w_data(1)),...
				sprintf('Data w=%.0frad/s', w_data(w_middle)),...
				sprintf('Data w=%.0frad/s', w_data(end)), 'Location', 'Best');
		end
		function PlotFitw(self)
			J_data = reshape(self.w_J_data(:, 2), [], 17);
			J_data = J_data(:, 1);
			w_data = reshape(self.w_J_data(:, 1), [], 17);
			w_data = w_data(1, :);
			T_data = reshape(self.T_data, [], 17)';
			Q_data = reshape(self.Q_data, [], 17)';
			w_range = 0:w_data(end)/100:w_data(end);
			J_middle = ceil(length(J_data)/2);
			figure();
			title(self.Name + " Thrust vs w");
			hold('on');
			grid('on');
			xlabel('w (rad/s)');
			ylabel('T (N)');
			plot(w_range, self.T(w_range, J_data(1)), '-r', 'LineWidth', 2);
			plot(w_range, self.T(w_range, J_data(J_middle)), '-g', 'LineWidth', 2);
			plot(w_range, self.T(w_range, J_data(end)), '-b', 'LineWidth', 2);
			plot(w_data, T_data(:, 1), 'xr', 'LineWidth', 2);
			plot(w_data, T_data(:, J_middle), 'xg', 'LineWidth', 2);
			plot(w_data, T_data(:, end), 'xb', 'LineWidth', 2);
			legend(...
				sprintf('Fit J=%.2f', J_data(1)),...
				sprintf('Fit J=%.2f', J_data(J_middle)),...
				sprintf('Fit J=%.2f', J_data(end)),...
				sprintf('Data J=%.2f', J_data(1)),...
				sprintf('Data J=%.2f', J_data(J_middle)),...
				sprintf('Data J=%.2f', J_data(end)), 'Location', 'Best');
			figure();
			title(self.Name + " Torque vs w");
			hold('on');
			grid('on');
			xlabel('w (rad/s)');
			ylabel('Q (N.m)');
			plot(w_range, self.Q(w_range, J_data(1)), '-r', 'LineWidth', 2);
			plot(w_range, self.Q(w_range, J_data(J_middle)), '-g', 'LineWidth', 2);
			plot(w_range, self.Q(w_range, J_data(end)), '-b', 'LineWidth', 2);
			plot(w_data, Q_data(:, 1), 'xr', 'LineWidth', 2);
			plot(w_data, Q_data(:, J_middle), 'xg', 'LineWidth', 2);
			plot(w_data, Q_data(:, end), 'xb', 'LineWidth', 2);
			legend(...
				sprintf('Fit J=%.2f', J_data(1)),...
				sprintf('Fit J=%.2f', J_data(J_middle)),...
				sprintf('Fit J=%.2f', J_data(end)),...
				sprintf('Data J=%.2f', J_data(1)),...
				sprintf('Data J=%.2f', J_data(J_middle)),...
				sprintf('Data J=%.2f', J_data(end)), 'Location', 'Best');
		end
	end
end
