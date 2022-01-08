classdef Vehicle
	properties
		fan Fan
		air Air
		L
		Dw
		Mw
		Iw
		m
		P
		f
		b
		r
		i
		s
	end
	methods
		function self = Vehicle(fan, air, m, L, r)
			self.fan = fan;
			self.air = air;
			self.Dw = 0.15*L;
			self.Mw = (self.Dw^2-8.35e-3^2)*pi/4*5e-3*0.6e3;
			self.Iw = self.Mw*self.Dw^2/8;
			self.m = m + fan.m + self.Mw;
			self.P = ((m+fan.m)/2)/(2*(6.35e-3/2)*5e-3);
			self.f = 2*pi^2*0.35/self.P*(6.35e-3/2)/1e-3;
			self.b = 2*(6.35e-3/2)^2*self.f*5e-3*self.P*2/(2*pi)*60;
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
		function [a, Vt, D, T, Q, B, F] = Acceleration(self, V)
			Vt = self.air.TrueSpeed(V);
			D = -0.003.*Vt.^2;
			w = self.s.*V;
			B = self.b.*w;
			[T, Q] = self.fan.Find(self.air.R, Vt, w);
			F = D+T-self.s.*Q-(2/self.Dw).*B;
			a = F/self.i;
		end
		function [Vmin, Vmax] = SpeedBoundary(self)
			Vmin = max(self.air.V, min(self.fan.w_data)/self.s);
			Vmax = max(self.fan.w_data)/self.s;
		end
	end
end
