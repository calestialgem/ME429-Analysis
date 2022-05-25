function [v_top, d_top] = SearchWheelDiameters(air, fan, d_range, F_d)
    v_range = zeros(size(d_range));
    for k = 1:length(d_range)
        vehicle = Vehicle(air, fan, d_range(k), F_d);
        [v_min, v_max] = vehicle.SpeedBoundary();
        v_range(k) = BisectionMethod(@(v) vehicle.Acceleration(v), v_min, v_max, 1e-6, 1e3);
    end
    [v_top, k_top] = max(v_range);
    d_top = d_range(k_top);
    figure();
    hold('on');
    grid('on');
    title('Top Speed vs Wheel Diameter');
    xlabel('d (m)');
    ylabel('v_{top} (m/s)');
    plot(d_range, v_range, 'LineWidth', 2);
    saveas(gcf, 'Top Speed vs Wheel Diameter', 'jpeg');
end
