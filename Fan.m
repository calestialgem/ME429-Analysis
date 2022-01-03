classdef Fan
	properties
		J_data
		w_data
		Ct_data
		Cq_data
		Ct
		Cq
	end
	methods
		function self = Fan(J_data, w_data, Ct_data, Cp_data)
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
		function [T, Q] = Find(self, rho, D, V, w)
			J = V/(w*D);
			T = rho*w^2*D^4*self.Ct(J, w);
			Q = rho*w^2*D^5*self.Cq(J, w);
		end
	end
end
