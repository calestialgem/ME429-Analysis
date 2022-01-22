function v_range = VelocityRelations(vehicle)
	[v_min, v_max] = vehicle.SpeedBoundary();
	v_range = v_min:(v_max-v_min)/1e3:v_max;
	[a_range, ~, F_t_range, F_q_range, F_k_range, F_net_range] = vehicle.Acceleration(v_range);
	[~, k_top] = min(abs(a_range));
	v_bounds = [v_min, v_range(k_top)];
	figure();
	hold('on');
	grid('on');
	plot(v_range, a_range, 'LineWidth', 2);
	xlabel('v (m/s)');
	xlim(v_bounds);
	ylabel('a (m/s^2)');
	title(sprintf('Acceleration vs Velocity Z=%.2f', vehicle.Z));
	figure();
	hold('on');
	grid('on');
	plot(v_range, F_t_range, 'LineWidth', 2);
	plot(v_range, F_q_range, 'LineWidth', 2);
	plot(v_range, F_k_range, 'LineWidth', 2);
	plot(v_range, F_net_range, 'LineWidth', 2);
	xlabel('v (m/s)');
	xlim(v_bounds);
	ylabel('F (N)');
	title(sprintf('Forces vs Velocity Z=%.2f', vehicle.Z));
	legend('F_t', 'F_q', 'F_k', 'F_{net}', 'Location', 'Best');
end
