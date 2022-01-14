classdef Vehicle
	properties
		fan Fan
		air Air
		L
		Dw
		Mw
		Iw
		m
		r
		i
		s
	end
	methods
		function self = Vehicle(fan, air, r)
			self.fan = fan;
			self.air = air;
			L = 35e-2;
			self.Dw = 0.15*L;
			m = 350e-3;
			wheelThickness = 10e-3;
			wheelDensity = 0.6e3;
			self.Mw = self.Dw^2*pi/4*wheelThickness*wheelDensity;
			self.Iw = self.Mw*self.Dw^2/8;
			self.m = m + fan.m + self.Mw;
			self.L = L;
			self.r = r;
			self = self.Findi();
			self = self.Finds();
		end
		function self = Findi(self)
			self.i = self.m+(12*self.Iw+4*self.fan.I/self.r^2)/self.Dw^2;
		end
		function self = Finds(self)
			self.s = 2/(self.r*self.Dw);
		end
		function self = Setr(self, r)
			self.r = r;
			self = self.Findi();
			self = self.Finds();
		end
		function [a, Vt, T, Q, F] = Acceleration(self, V)
			Vt = self.air.TrueSpeed(V);
			w = self.s.*V;
			[T, Q] = self.fan.Find(Vt, w);
			F = T-self.s.*Q;
			a = F/self.i;
		end
		function [Vmin, Vmax] = SpeedBoundary(self)
			Vmin = max(self.air.V, self.fan.w_min/self.s);
			Vmax = self.fan.w_max/self.s;
		end
	end
end
