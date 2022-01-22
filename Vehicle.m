classdef Vehicle
	properties
		air Air
		fan Fan
		L
		Dw
		Mw
		Iw
		m
		SR
		i
		s
	end
	methods
		function self = Vehicle(air, fan, SR)
			self.air = air;
			self.fan = fan;
			L = 35e-2;
			self.Dw = 0.15*L;
			m = 350e-3;
			wheelThickness = 10e-3;
			wheelDensity = 0.6e3;
			self.Mw = self.Dw^2*pi/4*wheelThickness*wheelDensity;
			self.Iw = self.Mw*self.Dw^2/8;
			self.m = m + fan.m + self.Mw;
			self.L = L;
			self.SR = SR;
			self.i = self.m+(12*self.Iw+4*self.fan.I/self.SR^2)/self.Dw^2;
			self.s = 2/(self.SR*self.Dw);
		end
		function [a, Vt, T, Q, F] = Acceleration(self, V)
			Vt = self.air.TrueSpeed(V);
			w = self.s*V;
			[T, Q] = self.fan.Find(self.air, Vt, w);
			Q = -self.s*Q;
			F = T+Q;
			a = F/self.i;
		end
		function [v_min, v_max] = SpeedBoundary(self)
			v_min = max(self.air.V, self.fan.w_min/self.s);
			v_max = self.fan.w_max/self.s;
		end
	end
end
