function v_range = Simulate(vehicle, Tf)
	[v_min, ~] = vehicle.SpeedBoundary();
	[time, v_range] = RungeKuttaMethod(@(~, V) vehicle.Acceleration(V), 1e3, Tf, v_min);
	[a_range, ~, T_range, Q_range, F_range] = vehicle.Acceleration(v_range);
	figure();
	hold('on');
	grid('on');
	plot(time, v_range, 'LineWidth', 2);
	xlabel('Time (s)');
	ylabel('Velocity (m/s)');
	title(sprintf('Speed Diagram SR=%.2f', vehicle.SR));
	figure();
	hold('on');
	grid('on');
	plot(time, a_range, 'LineWidth', 2);
	xlabel('Time (s)');
	ylabel('Acceleration (m/s^2)');
	title(sprintf('Acceleration Diagram SR=%.2f', vehicle.SR));
	figure();
	hold('on');
	grid('on');
	plot(time, T_range, 'LineWidth', 2);
	plot(time, Q_range, 'LineWidth', 2);
	plot(time, F_range, 'LineWidth', 2);
	xlabel('Time (s)');
	ylabel('Force (N)');
	title(sprintf('Force Diagram SR=%.2f', vehicle.SR));
	legend('Thrust', 'Torque', 'Net', 'Location', 'Best');
end
