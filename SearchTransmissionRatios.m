function [v_top, SR_top] = SearchTransmissionRatios(air, fan, SR_range)
	v_range = zeros(size(SR_range));
	for k = 1:length(SR_range)
		vehicle = Vehicle(air, fan, SR_range(k));
		[v_min, v_max] = vehicle.SpeedBoundary();
		v_range(k) = BisectionMethod(@(v) vehicle.Acceleration(v), v_min, v_max, 1e-6, 1e3);
	end
	[v_top, k_top] = max(v_range);
	SR_top = SR_range(k_top);
	figure();
	hold('on');
	grid('on');
	title('Top Speed vs Transmission Ratio');
	xlabel('SR');
	ylabel('v_{top} (m/s)');
	plot(SR_range, v_range, 'LineWidth', 2);
end
