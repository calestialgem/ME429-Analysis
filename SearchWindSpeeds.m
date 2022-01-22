function SearchWindSpeeds(fan, v_w_range, Z_min, Z_max)
	Z_best_range = zeros(size(v_w_range));
	v_top_range = zeros(size(v_w_range));
	for k = 1:length(v_w_range)
		[Z_best, v_top] = BestTransmissionRatio(Air(v_w_range(k)), fan, Z_min, Z_max);
		Z_best_range(k) = Z_best;
		v_top_range(k) = v_top;
	end
	figure();
	hold('on');
	grid('on');
	title('Best Transmission Ratio vs Wind Speed');
	xlabel('v_w (m/s)');
	ylabel('Z_{best}');
	plot(v_w_range, Z_best_range, 'LineWidth', 2);
	saveas(gcf, 'Best Transmission Ratio vs Wind Speed', 'jpeg');
	figure();
	hold('on');
	grid('on');
	title('Top Speed vs Wind Speed');
	xlabel('v_w (m/s)');
	ylabel('v_{top} (m/s)');
	plot(v_w_range, v_top_range, 'LineWidth', 2);
	saveas(gcf, 'Top Speed vs Wind Speed', 'jpeg');
end
