classdef Air
	properties
		V
	end
	methods
		function self = Air(V)
			self.V = V;
		end
		function Vt = TrueSpeed(self, V)
			Vt = V-self.V;
		end
	end
end
