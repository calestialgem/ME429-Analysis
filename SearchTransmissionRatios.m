function [v_top, t_top] = SearchTransmissionRatios(air, fan, t_range)
	v_range = zeros(size(t_range));
	for k = 1:length(t_range)
		vehicle = Vehicle(air, fan, t_range(k));
		[v_min, v_max] = vehicle.SpeedBoundary();
		v_range(k) = BisectionMethod(@(v) vehicle.Acceleration(v), v_min, v_max, 1e-6, 1e3);
	end
	[v_top, k_top] = max(v_range);
	t_top = t_range(k_top);
	figure();
	hold('on');
	grid('on');
	title('Top Speed vs Transmission Ratio');
	xlabel('t');
	ylabel('v_{top} (m/s)');
	plot(t_range, v_range, 'LineWidth', 2);
end
