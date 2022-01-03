classdef Fan
	properties
		Name
		m
		D
		I
		J_data
		w_data
		Ct_data
		Cq_data
		Ct
		Cq
	end
	methods
		function self = Fan(name, m, D, J_data, w_data, Ct_data, Cp_data)
			self.Name = name;
			self.m = m*28.3495231e-3;
			self.D = D*2.54e-2;
			self.I = self.m*self.D^2/12;
			self.J_data = J_data ./ (2*pi);
			self.w_data = w_data .* (2*pi/60);
			self.Ct_data = Ct_data ./ (2*pi)^2;
			self.Cq_data = Cp_data ./ (2*pi)^4;
			N_J = length(self.J_data);
			N_w = length(self.w_data);
			N = N_J*N_w;
			J_all = zeros(N, 1);
			w_all = zeros(N, 1);
			Ct_all = zeros(N, 1);
			Cq_all = zeros(N, 1);
			for k = 1:N_w
				last = k*N_J;
				first = last - N_J + 1;
				elements = first:last;
				J_all(elements) = self.J_data;
				w_all(elements) = self.w_data(k);
				Ct_all(elements) = self.Ct_data(k, :);
				Cq_all(elements) = self.Cq_data(k, :);
			end
			points = [J_all, w_all];
			self.Ct = fit(points, Ct_all, 'poly55', 'Normalize', 'on');
			self.Cq = fit(points, Cq_all, 'poly55', 'Normalize', 'on');
		end
		function [T, Q] = Find(self, rho, V, w)
			J = V/(w*self.D);
			T = rho*w^2*self.D^4*self.Ct(J, w);
			Q = rho*w^2*self.D^5*self.Cq(J, w);
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
			plot(J_range, self.Ct(J_range, self.w_data(1)), '-r', 'LineWidth', 2);
			plot(J_range, self.Ct(J_range, self.w_data(w_middle)), '-g', 'LineWidth', 2);
			plot(J_range, self.Ct(J_range, self.w_data(end)), '-b', 'LineWidth', 2);
			plot(self.J_data, self.Ct_data(1, :), 'xr', 'LineWidth', 2);
			plot(self.J_data, self.Ct_data(w_middle, :), 'xg', 'LineWidth', 2);
			plot(self.J_data, self.Ct_data(end, :), 'xb', 'LineWidth', 2);
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
			plot(J_range, self.Cq(J_range, self.w_data(1)), '-r', 'LineWidth', 2);
			plot(J_range, self.Cq(J_range, self.w_data(w_middle)), '-g', 'LineWidth', 2);
			plot(J_range, self.Cq(J_range, self.w_data(end)), '-b', 'LineWidth', 2);
			plot(self.J_data, self.Cq_data(1, :), 'xr', 'LineWidth', 2);
			plot(self.J_data, self.Cq_data(w_middle, :), 'xg', 'LineWidth', 2);
			plot(self.J_data, self.Cq_data(end, :), 'xb', 'LineWidth', 2);
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
			plot(w_range, self.Ct(self.J_data(1), w_range), '-r', 'LineWidth', 2);
			plot(w_range, self.Ct(self.J_data(J_middle), w_range), '-g', 'LineWidth', 2);
			plot(w_range, self.Ct(self.J_data(end), w_range), '-b', 'LineWidth', 2);
			plot(self.w_data, self.Ct_data(:, 1), 'xr', 'LineWidth', 2);
			plot(self.w_data, self.Ct_data(:, J_middle), 'xg', 'LineWidth', 2);
			plot(self.w_data, self.Ct_data(:, end), 'xb', 'LineWidth', 2);
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
			plot(w_range, self.Cq(self.J_data(1), w_range), '-r', 'LineWidth', 2);
			plot(w_range, self.Cq(self.J_data(J_middle), w_range), '-g', 'LineWidth', 2);
			plot(w_range, self.Cq(self.J_data(end), w_range), '-b', 'LineWidth', 2);
			plot(self.w_data, self.Cq_data(:, 1), 'xr', 'LineWidth', 2);
			plot(self.w_data, self.Cq_data(:, J_middle), 'xg', 'LineWidth', 2);
			plot(self.w_data, self.Cq_data(:, end), 'xb', 'LineWidth', 2);
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
