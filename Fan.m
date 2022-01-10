classdef Fan
	properties
		Name
		m
		D
		I
		J_data
		w_data
		T_data
		Q_data
		T
		Q
		T_rms
		Q_rms
	end
	methods
		function self = Fan(name, m, D, J_data, w_data, T_data, Q_data)
			self.Name = name;
			self.m = m*28.3495231e-3;
			self.D = D*2.54e-2;
			self.I = self.m*self.D^2/12;
			self.J_data = J_data ./ (2*pi);
			self.w_data = w_data .* (2*pi/60);
			self.T_data = T_data ./ (2*pi)^2;
			self.Q_data = Q_data ./ (2*pi)^4;
			N_J = length(self.J_data);
			N_w = length(self.w_data);
			N = N_J*N_w;
			J_all = zeros(N, 1);
			w_all = zeros(N, 1);
			T_all = zeros(N, 1);
			Q_all = zeros(N, 1);
			for k = 1:N_w
				last = k*N_J;
				first = last - N_J + 1;
				elements = first:last;
				J_all(elements) = self.J_data;
				w_all(elements) = self.w_data(k);
				T_all(elements) = self.T_data(k, :);
				Q_all(elements) = self.Q_data(k, :);
			end
			points = [J_all, w_all];
			self.T = fit(points, T_all, 'poly55', 'Normalize', 'on');
			self.Q = fit(points, Q_all, 'poly55', 'Normalize', 'on');
			self.T_rms = sqrt(sum((self.T(points)-T_all).^2))/N/(max(T_all)-min(T_all));
			self.Q_rms = sqrt(sum((self.Q(points)-Q_all).^2))/N/(max(Q_all)-min(Q_all));
		end
		function [T, Q] = Find(self, R, V, w)
			J = V./(w.*self.D);
			T = R.*w.^2.*self.D^4.*self.T(J, w);
			Q = R.*w.^2.*self.D^5.*self.Q(J, w);
		end
		function RMS = RootMeanSquare(self)
			RMS = sprintf('Root Mean Squares T=%e Q=%e\n', self.T_rms, self.Q_rms);
		end
		function PlotFitJ(self)
			J_range = 0:self.J_data(end)/100:self.J_data(end);
			w_middle = ceil(length(self.w_data)/2);
			figure();
			title(self.Name + " C_t vs J");
			hold('on');
			grid('on');
			xlabel('J');
			ylabel('C_t');
			plot(J_range, self.T(J_range, self.w_data(1)), '-r', 'LineWidth', 2);
			plot(J_range, self.T(J_range, self.w_data(w_middle)), '-g', 'LineWidth', 2);
			plot(J_range, self.T(J_range, self.w_data(end)), '-b', 'LineWidth', 2);
			plot(self.J_data, self.T_data(1, :), 'xr', 'LineWidth', 2);
			plot(self.J_data, self.T_data(w_middle, :), 'xg', 'LineWidth', 2);
			plot(self.J_data, self.T_data(end, :), 'xb', 'LineWidth', 2);
			legend(...
				sprintf('Fit w=%.0frad/s', self.w_data(1)),...
				sprintf('Fit w=%.0frad/s', self.w_data(w_middle)),...
				sprintf('Fit w=%.0frad/s', self.w_data(end)),...
				sprintf('Data w=%.0frad/s', self.w_data(1)),...
				sprintf('Data w=%.0frad/s', self.w_data(w_middle)),...
				sprintf('Data w=%.0frad/s', self.w_data(end)), 'Location', 'Best');
			figure();
			title(self.Name + " C_q vs J");
			hold('on');
			grid('on');
			xlabel('J');
			ylabel('C_q');
			plot(J_range, self.Q(J_range, self.w_data(1)), '-r', 'LineWidth', 2);
			plot(J_range, self.Q(J_range, self.w_data(w_middle)), '-g', 'LineWidth', 2);
			plot(J_range, self.Q(J_range, self.w_data(end)), '-b', 'LineWidth', 2);
			plot(self.J_data, self.Q_data(1, :), 'xr', 'LineWidth', 2);
			plot(self.J_data, self.Q_data(w_middle, :), 'xg', 'LineWidth', 2);
			plot(self.J_data, self.Q_data(end, :), 'xb', 'LineWidth', 2);
			legend(...
				sprintf('Fit w=%.0frad/s', self.w_data(1)),...
				sprintf('Fit w=%.0frad/s', self.w_data(w_middle)),...
				sprintf('Fit w=%.0frad/s', self.w_data(end)),...
				sprintf('Data w=%.0frad/s', self.w_data(1)),...
				sprintf('Data w=%.0frad/s', self.w_data(w_middle)),...
				sprintf('Data w=%.0frad/s', self.w_data(end)), 'Location', 'Best');
		end
		function PlotFitw(self)
			w_range = 0:self.w_data(end)/100:self.w_data(end);
			J_middle = ceil(length(self.J_data)/2);
			figure();
			title(self.Name + " C_t vs w");
			hold('on');
			grid('on');
			xlabel('w (rad/s)');
			ylabel('C_t');
			plot(w_range, self.T(self.J_data(1), w_range), '-r', 'LineWidth', 2);
			plot(w_range, self.T(self.J_data(J_middle), w_range), '-g', 'LineWidth', 2);
			plot(w_range, self.T(self.J_data(end), w_range), '-b', 'LineWidth', 2);
			plot(self.w_data, self.T_data(:, 1), 'xr', 'LineWidth', 2);
			plot(self.w_data, self.T_data(:, J_middle), 'xg', 'LineWidth', 2);
			plot(self.w_data, self.T_data(:, end), 'xb', 'LineWidth', 2);
			legend(...
				sprintf('Fit J=%.2f', self.J_data(1)),...
				sprintf('Fit J=%.2f', self.J_data(J_middle)),...
				sprintf('Fit J=%.2f', self.J_data(end)),...
				sprintf('Data J=%.2f', self.J_data(1)),...
				sprintf('Data J=%.2f', self.J_data(J_middle)),...
				sprintf('Data J=%.2f', self.J_data(end)), 'Location', 'Best');
			figure();
			title(self.Name + " C_q vs w");
			hold('on');
			grid('on');
			xlabel('w (rad/s)');
			ylabel('C_q');
			plot(w_range, self.Q(self.J_data(1), w_range), '-r', 'LineWidth', 2);
			plot(w_range, self.Q(self.J_data(J_middle), w_range), '-g', 'LineWidth', 2);
			plot(w_range, self.Q(self.J_data(end), w_range), '-b', 'LineWidth', 2);
			plot(self.w_data, self.Q_data(:, 1), 'xr', 'LineWidth', 2);
			plot(self.w_data, self.Q_data(:, J_middle), 'xg', 'LineWidth', 2);
			plot(self.w_data, self.Q_data(:, end), 'xb', 'LineWidth', 2);
			legend(...
				sprintf('Fit J=%.2f', self.J_data(1)),...
				sprintf('Fit J=%.2f', self.J_data(J_middle)),...
				sprintf('Fit J=%.2f', self.J_data(end)),...
				sprintf('Data J=%.2f', self.J_data(1)),...
				sprintf('Data J=%.2f', self.J_data(J_middle)),...
				sprintf('Data J=%.2f', self.J_data(end)), 'Location', 'Best');
		end
	end
end
