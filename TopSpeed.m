function v_top = TopSpeed(vehicle)
	[v_min, v_max] = vehicle.SpeedBoundary();
	v_top = BisectionMethod(@(v) vehicle.Acceleration(v), v_min, v_max*1000, 1e-6, 1e3);
end
