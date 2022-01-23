function [Z_best, v_top] = BestTransmissionRatio(air, fan, Z_min, Z_max, F_d)
	[Z_best, v_top] = fminbnd(@(Z) -TopSpeed(Vehicle(air, fan, Z, F_d)), Z_min, Z_max);
	if isnan(v_top)
		Z_best = NaN;
	else
		v_top = -v_top;
	end
end
