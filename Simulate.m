function v = Simulate(vehicle, Tf)
	[Vmin, Vmax] = vehicle.SpeedBoundary();
	[t, v] = RungeKuttaMethod(@(~, V) vehicle.Acceleration(V), 1e3, Tf, Vmin);
	[A, Vt, T, Q, B, F] = vehicle.Acceleration(v);
	figure();
	hold('on');
	grid('on');
	plot(t, v, 'LineWidth', 2);
	xlabel('Time (s)');
	ylabel('Velocity (m/s)');
	title(sprintf('Speed Diagram t=%.2f', vehicle.t));
	figure();
	hold('on');
	grid('on');
	plot(t, A, 'LineWidth', 2);
	xlabel('Time (s)');
	ylabel('Acceleration (m/s^2)');
	title(sprintf('Acceleration Diagram t=%.2f', vehicle.t));
	figure();
	hold('on');
	grid('on');
	plot(t, T, 'LineWidth', 2);
	plot(t, Q, 'LineWidth', 2);
	plot(t, B, 'LineWidth', 2);
	plot(t, F, 'LineWidth', 2);
	xlabel('Time (s)');
	ylabel('Force (N)');
	title(sprintf('Force Diagram t=%.2f', vehicle.t));
	legend('Thrust', 'Torque', 'Bearing Friction', 'Net', 'Location', 'Best');
end
