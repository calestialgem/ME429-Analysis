function [v_top, x_top, k_top] = SearchParameter(parameter)
    v_range = zeros(1, parameter.count());
    for k = 1:parameter.count()
        vehicle = parameter.vehicle(k);
        [v_min, v_max] = vehicle.SpeedBoundary();
        v_range(k) = BisectionMethod(@(v) vehicle.Acceleration(v), v_min, v_max, 1e-6, 1e3);
    end
    [v_top, k_top] = max(v_range);
    x_top = parameter.x(k_top);
    x_title = sprintf('Top Speed vs %s', parameter.name());
    figure();
    hold('on');
    grid('on');
    title(x_title);
    xlabel(parameter.label());
    ylabel('v_{top} (m/s)');
    plot(parameter.range, v_range, 'LineWidth', 2);
    saveas(gcf, x_title, 'jpeg');
end
