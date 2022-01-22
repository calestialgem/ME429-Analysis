function [t_best, v_top] = BestTransmissionRatio(air, fan, t_min, t_max)
	[t_best, v_top] = fminbnd(@(t) -TopSpeed(Vehicle(air, fan, t)), t_min, t_max);
	v_top = -v_top;
end
