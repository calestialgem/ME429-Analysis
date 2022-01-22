classdef Vehicle
	properties
		air Air
		fan Fan
		L
		Dw
		Mw
		Iw
		m
		b
		t
		i
		s
	end
	methods
		function self = Vehicle(air, fan, t)
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
			shaftRadius = 6.35e-3/2;
			bearingClearence = 1e-3;
			bearingLength = 10e-3;
			bearingLoad = m + fan.m;
			oilViscosity = 0.35;
			self.b = 4*pi*oilViscosity*shaftRadius^3*bearingLength/bearingClearence/self.Dw;
			self.t = t;
			self.i = self.m+(12*self.Iw+4*self.fan.I/self.t^2)/self.Dw^2;
			self.s = 2/(self.t*self.Dw);
		end
		function [a, Vt, T, Q, B, F] = Acceleration(self, V)
			Vt = self.air.TrueSpeed(V);
			w = self.s*V;
			[T, Q] = self.fan.Find(Vt, w);
			Q = -self.s*Q;
			B = -self.b*w;
			F = T+Q+B;
			a = F/self.i;
		end
		function [v_min, v_max] = SpeedBoundary(self)
			v_min = max(self.air.V, self.fan.w_min/self.s);
			v_max = self.fan.w_max/self.s;
		end
	end
end
