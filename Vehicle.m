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
		function self = Vehicle(fan, air, r)
			self.fan = fan;
			self.air = air;
			L = 35e-2;
			self.Dw = 0.15*L;
			m = 350e-3;
			wheelThickness = 10e-3;
			wheelDensity = 0.6e3;
			hubThickness = 10e-3;
			shaft = 6.35e-3/2;
			clearance = 1e-3;
			viscosity = 0.35;
			self.Mw = (self.Dw^2-((shaft+clearance)*2)^2)*pi/4*wheelThickness*wheelDensity;
			self.Iw = self.Mw*self.Dw^2/8;
			self.m = m + fan.m + self.Mw;
			self.P = ((m+fan.m)/2)/(2*shaft*hubThickness);
			self.f = 2*pi^2*viscosity/self.P*shaft/clearance;
			self.b = 2*shaft^2*self.f*hubThickness*self.P*2/(2*pi)*60;
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
