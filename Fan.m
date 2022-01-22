classdef Fan
	properties
		Name
		air
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
		function self = Fan(name, air, m, D, w_min, w_max, w_J_data, Ct_data, Cq_data)
			self.Name = name;
			self.air = air;
			self.m = m;
			self.D = D;
			self.I = self.m*self.D^2/12;
			self.Ct = fit(w_J_data, Ct_data, 'poly55', 'Normalize', 'on');
			self.Cq = fit(w_J_data, Cq_data, 'poly55', 'Normalize', 'on');
			self.w_min = w_min;
			self.w_max = w_max;
			self.w_J_data = w_J_data;
			self.Ct_data = Ct_data;
			self.Cq_data = Cq_data;
			self.Ct_rms = sqrt(sum((self.Ct(w_J_data)-Ct_data).^2))/size(w_J_data, 1)/(max(Ct_data)-min(Ct_data));
			self.Cq_rms = sqrt(sum((self.Cq(w_J_data)-Cq_data).^2))/size(w_J_data, 1)/(max(Cq_data)-min(Cq_data));
		end
		function [T, Q] = Find(self, V, w)
			J = V./(w.*self.D);
			T = (self.air.R * self.D^4) * w.^2 .* self.Ct(w, J);
			Q = (self.air.R * self.D^5) * w.^2 .* self.Cq(w, J);
		end
		function RMS = RootMeanSquare(self)
			RMS = sprintf('Root Mean Squares Ct=%e Cq=%e\n', self.Ct_rms, self.Cq_rms);
		end
		function PlotFitJ(self)
			J_data = reshape(self.w_J_data(:, 2), [], 17);
			J_data = J_data(:, 1);
			w_data = reshape(self.w_J_data(:, 1), [], 17);
			w_data = w_data(1, :);
			Ct_data = reshape(self.Ct_data, [], 17)';
			Cq_data = reshape(self.Cq_data, [], 17)';
			J_range = 0:J_data(end)/100:J_data(end);
			w_middle = ceil(length(w_data)/2);
			figure();
			title(self.Name + " Thrust Coefficient vs J");
			hold('on');
			grid('on');
			xlabel('J');
			ylabel('Ct');
			plot(J_range, self.Ct(w_data(1), J_range), '-r', 'LineWidth', 2);
			plot(J_range, self.Ct(w_data(w_middle), J_range), '-g', 'LineWidth', 2);
			plot(J_range, self.Ct(w_data(end), J_range), '-b', 'LineWidth', 2);
			plot(J_data, Ct_data(1, :), 'xr', 'LineWidth', 2);
			plot(J_data, Ct_data(w_middle, :), 'xg', 'LineWidth', 2);
			plot(J_data, Ct_data(end, :), 'xb', 'LineWidth', 2);
			legend(...
				sprintf('Fit w=%.0frad/s', w_data(1)),...
				sprintf('Fit w=%.0frad/s', w_data(w_middle)),...
				sprintf('Fit w=%.0frad/s', w_data(end)),...
				sprintf('Data w=%.0frad/s', w_data(1)),...
				sprintf('Data w=%.0frad/s', w_data(w_middle)),...
				sprintf('Data w=%.0frad/s', w_data(end)), 'Location', 'Best');
			figure();
			title(self.Name + " Torque Coefficient vs J");
			hold('on');
			grid('on');
			xlabel('J');
			ylabel('Cq');
			plot(J_range, self.Cq(w_data(1), J_range), '-r', 'LineWidth', 2);
			plot(J_range, self.Cq(w_data(w_middle), J_range), '-g', 'LineWidth', 2);
			plot(J_range, self.Cq(w_data(end), J_range), '-b', 'LineWidth', 2);
			plot(J_data, Cq_data(1, :), 'xr', 'LineWidth', 2);
			plot(J_data, Cq_data(w_middle, :), 'xg', 'LineWidth', 2);
			plot(J_data, Cq_data(end, :), 'xb', 'LineWidth', 2);
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
			Ct_data = reshape(self.Ct_data, [], 17)';
			Cq_data = reshape(self.Cq_data, [], 17)';
			w_range = 0:w_data(end)/100:w_data(end);
			J_middle = ceil(length(J_data)/2);
			figure();
			title(self.Name + " Thrust Coefficient vs w");
			hold('on');
			grid('on');
			xlabel('w (rad/s)');
			ylabel('Ct');
			plot(w_range, self.Ct(w_range, J_data(1)), '-r', 'LineWidth', 2);
			plot(w_range, self.Ct(w_range, J_data(J_middle)), '-g', 'LineWidth', 2);
			plot(w_range, self.Ct(w_range, J_data(end)), '-b', 'LineWidth', 2);
			plot(w_data, Ct_data(:, 1), 'xr', 'LineWidth', 2);
			plot(w_data, Ct_data(:, J_middle), 'xg', 'LineWidth', 2);
			plot(w_data, Ct_data(:, end), 'xb', 'LineWidth', 2);
			legend(...
				sprintf('Fit J=%.2f', J_data(1)),...
				sprintf('Fit J=%.2f', J_data(J_middle)),...
				sprintf('Fit J=%.2f', J_data(end)),...
				sprintf('Data J=%.2f', J_data(1)),...
				sprintf('Data J=%.2f', J_data(J_middle)),...
				sprintf('Data J=%.2f', J_data(end)), 'Location', 'Best');
			figure();
			title(self.Name + " Torque Coefficient vs w");
			hold('on');
			grid('on');
			xlabel('w (rad/s)');
			ylabel('Cq');
			plot(w_range, self.Cq(w_range, J_data(1)), '-r', 'LineWidth', 2);
			plot(w_range, self.Cq(w_range, J_data(J_middle)), '-g', 'LineWidth', 2);
			plot(w_range, self.Cq(w_range, J_data(end)), '-b', 'LineWidth', 2);
			plot(w_data, Cq_data(:, 1), 'xr', 'LineWidth', 2);
			plot(w_data, Cq_data(:, J_middle), 'xg', 'LineWidth', 2);
			plot(w_data, Cq_data(:, end), 'xb', 'LineWidth', 2);
			legend(...
				sprintf('Fit J=%.2f', J_data(1)),...
				sprintf('Fit J=%.2f', J_data(J_middle)),...
				sprintf('Fit J=%.2f', J_data(end)),...
				sprintf('Data J=%.2f', J_data(1)),...
				sprintf('Data J=%.2f', J_data(J_middle)),...
				sprintf('Data J=%.2f', J_data(end)), 'Location', 'Best');
		end
		function PlotFitTQ(self, vehicle)
			[Vmin, Vmax] = vehicle.SpeedBoundary();
			v = Vmin:(Vmax-Vmin)/1000:Vmax;
			w = vehicle.s * v;
			[T, Q] = self.Find(self.air.TrueSpeed(v), w);
			Ft = T;
			Fq = vehicle.s*Q;
			Fe = Ft-Fq;
			[~, k0] = min(abs(Fe));

			figure();
			hold('on');
			grid('on');
			title(sprintf('Fan Forces vs Vehicle Velocity t=%.2f', vehicle.t));
			xlabel('Velocity (m/s)');
			ylabel('Force (N)');
			plot(v, Ft, 'LineWidth', 2);
			plot(v, Fq, 'LineWidth', 2);
			plot(v, Fe, 'LineWidth', 2);
			plot(v(k0), Ft(k0), 'x', 'LineWidth', 2);
			xlim([Vmin v(k0)*1.1]);
			legend('Thrust', 'Torque', 'Excess', 'Top', 'Location', 'Best');
		end
	end
end
