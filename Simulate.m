function v = Simulate(vehicle, Tf)
	[Vmin, Vmax] = vehicle.SpeedBoundary();
	[t, v] = RungeKuttaMethod(@(~, V) vehicle.Acceleration(V), 1e3, Tf, Vmin);
	[A, Vt, D, T, Q, B, F] = vehicle.Acceleration(v);
	figure();
	hold('on');
	grid('on');
	plot(t, v, '-', 'LineWidth', 2);
	yline(Vmax, '--', 'LineWidth', 2);
	xlabel('t (s)');
	ylabel('v (m/s)');
	title(sprintf('Speed Diagram r=%.2f', vehicle.r));
	legend('Speed', 'Data End', 'Location', 'Best');
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
	plot(t, D, '-', 'Color', '#a87d32', 'LineWidth', 2);
	plot(t, T, '-', 'Color', '#32a865', 'LineWidth', 2);
	plot(t, (-vehicle.s).*Q, '-', 'Color', '#a83232', 'LineWidth', 2);
	plot(t, (-2/vehicle.Dw).*B, '-', 'Color', '#206e35', 'LineWidth', 2);
	plot(t, F, '-', 'Color', '#323ca8', 'LineWidth', 2);
	xlabel('t (s)');
	ylabel('F (N)');
	title(sprintf('Force Diagram r=%.2f', vehicle.r));
	legend('Body Drag Force', 'Thrust Force', 'Fan Force', 'Bearing Friction', 'Net Force', 'Location', 'Best');
end
