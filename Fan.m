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
	end
end
