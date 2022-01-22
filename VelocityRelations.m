function v_range = VelocityRelations(vehicle)
	[v_min, v_max] = vehicle.SpeedBoundary();
	v_range = v_min:(v_max-v_min)/1e3:v_max;
	[a_range, ~, F_t_range, F_q_range, F_c_range, F_k_range, F_net_range] = vehicle.Acceleration(v_range);
	[~, k_top] = min(abs(a_range));
	if a_range(k_top) < 0
		k_top = k_top - 1;
	end
	k_range = 1:k_top;
	figure();
	hold('on');
	grid('on');
	plot(v_range(k_range), a_range(k_range), 'LineWidth', 2);
	ylabel('a (m/s^2)');
	xlabel('v (m/s)');
	title(sprintf('Acceleration vs Velocity Z=%.2f', vehicle.Z));
	saveas(gcf, 'Acceleration vs Velocity', 'jpeg');
	figure();
	hold('on');
	grid('on');
	plot(v_range(k_range), F_t_range(k_range), 'LineWidth', 2);
	plot(v_range(k_range), F_q_range(k_range), 'LineWidth', 2);
	plot(v_range(k_range), F_c_range(k_range), 'LineWidth', 2);
	plot(v_range(k_range), F_k_range(k_range), 'LineWidth', 2);
	plot(v_range(k_range), F_net_range(k_range), 'LineWidth', 2);
	ylabel('F (N)');
	xlabel('v (m/s)');
	title(sprintf('Forces vs Velocity Z=%.2f', vehicle.Z));
	legend('F_t', 'F_q', 'F_c', 'F_k', 'F_{net}', 'Location', 'Best');
	saveas(gcf, 'Forces vs Velocity', 'jpeg');
end
