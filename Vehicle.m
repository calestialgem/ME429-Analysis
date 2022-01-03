classdef Vehicle
	properties
		fan Fan
		air Air
		m
		L
		Dw
		Iw
		r
		i
		s
	end
	methods
		function self = Vehicle(fan, air, m, L, r)
			self.fan = fan;
			self.air = air;
			self.m = m + fan.m;
			self.L = L;
			self.Dw = 0.15*L;
			self.Iw = 0;
			self.r = r;
			self.Findi();
			self.Finds();
		end
		function self = Findi(self)
			self.i = self.m+(12*self.Iw+4*self.fan.I/self.r^2)/self.Dw^2;
		end
		function self = Finds(self)
			self.s = 2/(self.r*self.Dw);
		end
		function self = Setr(self, r)
			self.r = r;
			self.Findi();
			self.Finds();
		end
		function a = Acceleration(self, V)
			Vt = V-self.air.V;
			D = -0.003*Vt^2;
			[T, Q] = self.fan.Find(self.air.R, Vt, self.s*V);
			a = (D+T-self.s*Q)/self.i;
		end
	end
end
