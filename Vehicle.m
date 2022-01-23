classdef Vehicle
	properties
		air Air
		fan Fan
		d
		Z
		F_d
		mul_a
		mul_q
		mul_k
		mul_c
	end
	methods
		function self = Vehicle(air, fan, Z, F_d)
			self.air = air;
			self.fan = fan;
			L = 35e-2;
			self.d = 0.15*L;
			self.Z = Z;
			self.F_d = F_d;
			t_wheel = 10e-3;
			R_wheel = 0.6e3;
			m_wheel = self.d^2*pi/4*t_wheel*R_wheel;
			I_wheel = m_wheel*self.d^2/8;
			m_body = 350e-3;
			m = m_body+fan.m+m_wheel*3;
			self.mul_a = (m+(12*I_wheel+4*self.fan.I/self.Z^2)/self.d^2)^-1;
			% https://www.grainger.com/know-how/equipment-information/kh-types-of-belt-drives-efficiency
			n = 0.9;
			self.mul_q = 2/(n*self.Z*self.d);
			% https://www.engineeringtoolbox.com/dynamic-viscosity-motor-oils-d_1759.html
			u = 0.63;
			mul_u = 2*pi*u*self.mul_q;
			c_r = 6.35e-3/2;
			c_c = 1e-3;
			c_l = 87.5e-3;
			self.mul_c = mul_u*c_r^3*c_l/c_c;
			k_r = 6.35e-3/2;
			k_c = 1e-3;
			k_l = 10e-3;
			self.mul_k = self.Z*mul_u*k_r^3*k_l/k_c;
		end
		function [a, v_t, F_t, F_q, F_c, F_k, F_d, F_net] = Acceleration(self, v)
			v_t = self.air.TrueSpeed(v);
			w_b = 2/self.d*v;
			w_p = w_b/self.Z;
			[F_t, T_q] = self.fan.Find(self.air, v_t, w_p);
			F_q = self.mul_q*T_q;
			F_c = self.mul_c*w_p;
			F_k = self.mul_k*w_b;
			F_d = self.F_d(v_t);
			F_net = F_t-F_q-F_c-F_k-F_d;
			a = F_net*self.mul_a;
		end
		function [v_min, v_max] = SpeedBoundary(self)
			v_min = max(self.air.V, self.fan.w_min*self.d/2*self.Z);
			v_max = self.fan.w_max*self.d/2*self.Z;
		end
	end
end
