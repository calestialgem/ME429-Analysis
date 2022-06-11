function SearchWindSpeeds(fan, v_w_range, d_fixed, d_range, F_d)
    d_best_range = zeros(size(v_w_range));
    v_top_range = zeros(size(v_w_range));
    v_fixed_range = zeros(size(v_w_range));
    for k = 1:length(v_w_range)
        air = Air(v_w_range(k));
        [Z_best, v_top] = BestWheelDiameter(air, fan, d_range, F_d);
        d_best_range(k) = Z_best;
        v_top_range(k) = v_top;
        v_fixed_range(k) = TopSpeed(Vehicle(air, fan, d_fixed, F_d));
    end
    figure();
    hold('on');
    grid('on');
    title('Best Wheel Diameter vs Wind Speed');
    xlabel('v_w (m/s)');
    ylabel('d_{best} (m)');
    plot(v_w_range, d_best_range, 'LineWidth', 2);
    saveas(gcf, 'Best Wheel Diameter vs Wind Speed', 'jpeg');
    figure();
    hold('on');
    grid('on');
    title('Top Speed vs Wind Speed');
    xlabel('v_w (m/s)');
    ylabel('v_{top} (m/s)');
    plot(v_w_range, v_top_range, 'LineWidth', 2);
    plot(v_w_range, v_fixed_range, 'LineWidth', 2);
    legend('d=d_{best}(v_w)', sprintf('d=%.1f mm', 1e3 * d_fixed), 'Location', 'Best');
    saveas(gcf, 'Top Speed vs Wind Speed', 'jpeg');
end
