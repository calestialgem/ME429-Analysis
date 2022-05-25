function [d_best, v_top] = BestWheelDiameter(air, fan, d_range, F_d)
    v_top_range = zeros(size(d_range));
    for k = 1:length(d_range)
        vehicle = Vehicle(air, fan, d_range(k), F_d);
        v_top_range(k) = TopSpeed(vehicle);
    end
    [v_top, k_best] = max(v_top_range);
    if isnan(v_top)
        d_best = NaN;
    else
        d_best = d_range(k_best);
    end
end
