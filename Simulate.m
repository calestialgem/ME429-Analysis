function v_range = Simulate(vehicle, t_f)
	[v_min, ~] = vehicle.SpeedBoundary();
	[t_range, v_range] = RungeKuttaMethod(@(~, V) vehicle.Acceleration(V), 1e3, t_f, v_min);
	[a_range, ~, F_t_range, F_q_range, F_c_range, F_k_range, F_d_range, F_net_range] = vehicle.Acceleration(v_range);
	figure();
	hold('on');
	grid('on');
	plot(t_range, v_range, 'LineWidth', 2);
	xlabel('t (s)');
	ylabel('v (m/s)');
	title(sprintf('Velocity vs Time Z=%.2f', vehicle.Z));
	saveas(gcf, 'Velocity vs Time', 'jpeg');
	figure();
	hold('on');
	grid('on');
	plot(t_range, a_range, 'LineWidth', 2);
	xlabel('t (s)');
	ylabel('a (m/s^2)');
	title(sprintf('Acceleration vs Time Z=%.2f', vehicle.Z));
	saveas(gcf, 'Acceleration vs Time', 'jpeg');
	figure();
	hold('on');
	grid('on');
	plot(t_range, F_t_range, 'LineWidth', 2);
	plot(t_range, F_q_range, 'LineWidth', 2);
	plot(t_range, F_c_range, 'LineWidth', 2);
	plot(t_range, F_k_range, 'LineWidth', 2);
	plot(t_range, F_d_range, 'LineWidth', 2);
	plot(t_range, F_net_range, 'LineWidth', 2);
	xlabel('t (s)');
	ylabel('F (N)');
	title(sprintf('Forces vs Time Z=%.2f', vehicle.Z));
	legend('F_t', 'F_q', 'F_c', 'F_k', 'F_d', 'F_{net}', 'Location', 'Best');
	saveas(gcf, 'Forces vs Time', 'jpeg');
end
