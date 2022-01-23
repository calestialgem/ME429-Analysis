function [v_top, Z_top] = SearchTransmissionRatios(air, fan, Z_range, F_d)
	v_range = zeros(size(Z_range));
	for k = 1:length(Z_range)
		vehicle = Vehicle(air, fan, Z_range(k), F_d);
		[v_min, v_max] = vehicle.SpeedBoundary();
		v_range(k) = BisectionMethod(@(v) vehicle.Acceleration(v), v_min, v_max, 1e-6, 1e3);
	end
	[v_top, k_top] = max(v_range);
	Z_top = Z_range(k_top);
	figure();
	hold('on');
	grid('on');
	title('Top Speed vs Transmission Ratio');
	xlabel('Z');
	ylabel('v_{top} (m/s)');
	plot(Z_range, v_range, 'LineWidth', 2);
	saveas(gcf, 'Top Speed vs Transmission Ratio', 'jpeg');
end
