classdef Air
	properties
		V
		R
	end
	methods
		function self = Air(V, R)
			self.V = V;
			self.R = R;
		end
		function Vt = TrueSpeed(self, V)
			Vt = V-self.V;
		end
	end
end
