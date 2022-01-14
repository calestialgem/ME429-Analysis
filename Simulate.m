function v = Simulate(vehicle, Tf)
	[Vmin, Vmax] = vehicle.SpeedBoundary();
	[t, v] = RungeKuttaMethod(@(~, V) vehicle.Acceleration(V), 1e3, Tf, Vmin);
	[A, Vt, T, Q, F] = vehicle.Acceleration(v);
	figure();
	hold('on');
	grid('on');
	plot(t, v, '-', 'LineWidth', 2);
	xlabel('t (s)');
	ylabel('v (m/s)');
	title(sprintf('Speed Diagram r=%.2f', vehicle.r));
	figure();
	hold('on');
	grid('on');
	plot(t, A, '-', 'LineWidth', 2);
	xlabel('t (s)');
	ylabel('a (m/s^2)');
	title(sprintf('Acceleration Diagram r=%.2f', vehicle.r));
	figure();
	hold('on');
	grid('on');
	plot(t, T, '-', 'Color', '#32a865', 'LineWidth', 2);
	plot(t, (-vehicle.s).*Q, '-', 'Color', '#a83232', 'LineWidth', 2);
	plot(t, F, '-', 'Color', '#323ca8', 'LineWidth', 2);
	xlabel('t (s)');
	ylabel('F (N)');
	title(sprintf('Force Diagram r=%.2f', vehicle.r));
	legend('Thrust Force', 'Torque Force', 'Net Force', 'Location', 'Best');
end
