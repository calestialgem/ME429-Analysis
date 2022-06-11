classdef Vehicle
    properties
        air Air
        fan Fan
        d
        Z
        F_d
        mul_a
        mul_q
    end
    methods
        function self = Vehicle(air, fan, d, F_d)
            self.air = air;
            self.fan = fan;
            % L = 35e-2;
            self.d = d;
            self.Z = 1;
            self.F_d = F_d;
            m = 300e-3;
            % https://www.grainger.com/know-how/equipment-information/kh-types-of-belt-drives-efficiency
            n = 0.9;
            self.mul_a = (m + 4 * self.fan.I / (n * self.Z^2) / self.d^2)^ - 1;
            self.mul_q = 2 / (n * self.Z * self.d);
        end
        function [a, v_t, F_t, F_d, F_q, F_f, F_net] = Acceleration(self, v)
            v_t = self.air.TrueSpeed(v);
            w_b = 2 / self.d * v;
            w_p = w_b / self.Z;
            [F_t, T_q] = self.fan.Find(self.air, v_t, w_p);
            F_d = self.F_d(v_t);
            F_q = self.mul_q * T_q;
            F_f = 0.04905 + v / (20/3600e-3) * (0.0614214);
            F_net = F_t - F_d - F_q - F_f;
            a = F_net * self.mul_a;
        end
        function [v_min, v_max] = SpeedBoundary(self)
            v_min = max(self.air.V, self.fan.w_min * self.d / 2 * self.Z);
            v_max = self.fan.w_max * self.d / 2 * self.Z;
        end
    end
end
