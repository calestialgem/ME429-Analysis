classdef Air
    properties
        V
        R
    end
    methods
        function self = Air(V)
            self.V = V;
            self.R = 1.225;
        end
        function Vt = TrueSpeed(self, V)
            Vt = V - self.V;
        end
    end
end
