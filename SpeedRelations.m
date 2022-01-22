function v_range = SpeedRelations(vehicle)
	[v_min, v_max] = vehicle.SpeedBoundary();
	v_range = v_min:(v_max-v_min)/1e3:v_max;
	[a_range, ~, T_range, Q_range, B_range, F_range] = vehicle.Acceleration(v_range);
	[~, k_top] = min(abs(a_range));
	v_bounds = [v_min, v_range(k_top)];
	figure();
	hold('on');
	grid('on');
	plot(v_range, a_range, 'LineWidth', 2);
	xlabel('Velocity (m/s)');
	xlim(v_bounds);
	ylabel('Acceleration (m/s^2)');
	title(sprintf('Acceleration vs Speed SR=%.2f', vehicle.SR));
	figure();
	hold('on');
	grid('on');
	plot(v_range, T_range, 'LineWidth', 2);
	plot(v_range, Q_range, 'LineWidth', 2);
	plot(v_range, B_range, 'LineWidth', 2);
	plot(v_range, F_range, 'LineWidth', 2);
	xlabel('Velocity (m/s)');
	xlim(v_bounds);
	ylabel('Force (N)');
	title(sprintf('Force vs Speed SR=%.2f', vehicle.SR));
	legend('Thrust', 'Torque', 'Bearing Friction', 'Net', 'Location', 'Best');
end
