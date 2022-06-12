classdef Parameter
    properties
        air
        fan
        F_d
        F_f
        fixed
        range
        parameter
    end
    methods
        function self = Parameter(air, fan, F_d, F_f, fixed, range, parameter)
            self.air = air;
            self.fan = fan;
            self.F_d = F_d;
            self.F_f = F_f;
            self.fixed = fixed;
            self.range = range;
            self.parameter = parameter;
        end
        function count = count(self)
            count = length(self.range);
        end
        function x = x(self, k)
            x = self.range(k);
        end
        function vehicle = vehicle(self, k)
            if self.parameter
                d = self.fixed;
                Z = self.x(k);
            else
                d = self.x(k);
                Z = self.fixed;
            end
            vehicle = Vehicle(self.air, self.fan, self.F_d, self.F_f, d, Z);
        end
        function name = name(self)
            if self.parameter
                name = 'Transmission Ratio';
            else
                name = 'Wheel Diameter';
            end
        end
        function symbol = symbol(self)
            if self.parameter
                symbol = 'Z';
            else
                symbol = 'd';
            end
        end
        function label = label(self)
            if self.parameter
                label = 'Z';
            else
                label = 'd (m)';
            end
        end
        function best_label = best_label(self)
            if self.parameter
                best_label = 'Z_{best}';
            else
                best_label = 'd_{best} (m)';
            end
        end
        function format = format(self, x)
            if self.parameter
                format = sprintf('Z=%.3f', x);
            else
                format = sprintf('d=%.1f mm', x * 1e3);
            end
        end
        function subscript = subscript(self, x, sub)
            if self.parameter
                subscript = sprintf('Z_%s=%.3f', sub, x);
            else
                subscript = sprintf('d_%s=%.1f mm', sub, x * 1e3);
            end
        end
        function file_name = file_name(self)
            if self.parameter
                file_name = sprintf('d %.1f mm', self.fixed * 1e3);
            else
                file_name = sprintf('Z %.3f', self.fixed);
            end
        end
    end
end
