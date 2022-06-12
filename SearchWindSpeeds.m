function SearchWindSpeeds(fan, v_w_range, Z_fixed, Z_range, F_d, F_f)
    Z_best_range = zeros(size(v_w_range));
    v_top_range = zeros(size(v_w_range));
    v_fixed_range = zeros(size(v_w_range));
    for k = 1:length(v_w_range)
        air = Air(v_w_range(k));
        [Z_best, v_top] = BestTransmissionRatio(air, fan, Z_range, F_d, F_f);
        Z_best_range(k) = Z_best;
        v_top_range(k) = v_top;
        v_fixed_range(k) = TopSpeed(Vehicle(air, fan, Z_fixed, F_d, F_f));
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
    plot(v_w_range, v_fixed_range, 'LineWidth', 2);
    legend('Z=Z_{best}(v_w)', sprintf('Z=%.3f', Z_fixed), 'Location', 'Best');
    saveas(gcf, 'Top Speed vs Wind Speed', 'jpeg');
end
