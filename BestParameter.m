function [x_best, v_top] = BestParameter(parameter)
    v_top_range = zeros(1, parameter.count());
    for k = 1:parameter.count()
        vehicle = parameter.vehicle(k);
        v_top_range(k) = TopSpeed(vehicle);
    end
    [v_top, k_best] = max(v_top_range);
    if isnan(v_top)
        x_best = NaN;
    else
        x_best = parameter.x(k_best);
    end
end
