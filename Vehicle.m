classdef Vehicle
	properties
		air Air
		fan Fan
		d
		Z
		F_d
		mul_a
		mul_q
		mul_s
		mul_c
	end
	methods
		function self = Vehicle(air, fan, Z, F_d)
			self.air = air;
			self.fan = fan;
			L = 35e-2;
			self.d = 100e-3;
			self.Z = Z;
			self.F_d = F_d;
			m_wheel = 50e-3;
			I_wheel = m_wheel*self.d^2/8;
			% https://www.3d4makers.com/products/pla-filament
			R_pla = 1250;
			V_pla = 43864.018e-9;
			% https://link.springer.com/article/10.1007/s00226-015-0700-5
			R_balsa = (100+250)/2;
			V_balsa = 39578.46e-9;
			m_body = R_pla*V_pla+R_balsa*V_balsa;
			m = m_body+fan.m+m_wheel*3;
			self.mul_a = (m+(12*I_wheel+4*self.fan.I/self.Z^2)/self.d^2)^-1;
			% https://www.grainger.com/know-how/equipment-information/kh-types-of-belt-drives-efficiency
			n = 0.9;
			self.mul_q = 2/(n*self.Z*self.d);
			% https://www.engineeringtoolbox.com/dynamic-viscosity-motor-oils-d_1759.html
			u = 0.63;
            s_r = 6.35e-3/2;
			s_c = 1e-3;
			s_l = 10e-3;
			self.mul_s = 4*pi*u*s_r^3*s_l/s_c*4/self.d;
			c_r = 6.35e-3/2;
			c_c = 1e-3;
			c_l = 87.5e-3;
			self.mul_c = 2*pi*u*c_r^3*c_l/c_c*self.mul_q;
		end
		function [a, v_t, F_t, F_d, F_q, F_s, F_c, F_net] = Acceleration(self, v)
			v_t = self.air.TrueSpeed(v);
			w_b = 2/self.d*v;
			w_p = w_b/self.Z;
			[F_t, T_q] = self.fan.Find(self.air, v_t, w_p);
			F_d = self.F_d(v_t);
			F_q = self.mul_q*T_q;
			F_s = self.mul_s*w_b;
			F_c = self.mul_c*w_p;
			F_net = F_t-F_q-F_s-F_c-F_d;
			a = F_net*self.mul_a;
		end
		function [v_min, v_max] = SpeedBoundary(self)
			v_min = max(self.air.V, self.fan.w_min*self.d/2*self.Z);
			v_max = self.fan.w_max*self.d/2*self.Z;
		end
	end
end
