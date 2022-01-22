classdef Vehicle
	properties
		air Air
		fan Fan
		Z
		mul_k
		mul_a
		mul_q
	end
	methods
		function self = Vehicle(air, fan, Z)
			self.air = air;
			self.fan = fan;
			self.Z = Z;
			L = 35e-2;
			d = 0.15*L;
			t_wheel = 10e-3;
			R_wheel = 0.6e3;
			m_wheel = d^2*pi/4*t_wheel*R_wheel;
			I_wheel = m_wheel*d^2/8;
			m_body = 350e-3;
			m = m_body+fan.m+m_wheel*3;
			u = 0.4;
			k_r = 6.35e-3/2;
			k_c = 1e-3;
			k_l = 10e-3;
			self.mul_k = 4*pi*u*k_r^3*k_l/k_c/d;
			self.mul_a = (m+(12*I_wheel+4*self.fan.I/self.Z^2)/d^2)^-1;
			self.mul_q = 2/(self.Z*d);
		end
		function [a, v_t, F_t, F_q, F_k, F_net] = Acceleration(self, v)
			v_t = self.air.TrueSpeed(v);
			w_c = self.mul_q*v;
			w_k = self.Z*w_c;
			[F_t, T_q] = self.fan.Find(self.air, v_t, w_c);
			F_q = self.mul_q*T_q;
			F_k = self.mul_k*w_k;
			F_net = F_t-F_q-F_k;
			a = F_net*self.mul_a;
		end
		function [v_min, v_max] = SpeedBoundary(self)
			v_min = max(self.air.V, self.fan.w_min/self.mul_q);
			v_max = self.fan.w_max/self.mul_q;
		end
	end
end
