function [t_best, v_top] = BestTransmissionRatio(air, fan, t_min, t_max)
	[t_best, v_top] = fminbnd(@(t) -TopSpeed(Vehicle(air, fan, t)), t_min, t_max);
	if isnan(v_top)
		t_best = NaN;
	else
		v_top = -v_top;
	end
end
