function V = Simulate(vehicle)
	[Vmin, Vmax] = vehicle.SpeedBoundary();
	[V, T] = RungeKuttaMethod(@(~, v) vehicle.Acceleration(v), Vmin, 30, 1e4);
	
end
