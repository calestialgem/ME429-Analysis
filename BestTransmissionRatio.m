function [Z_best, v_top] = BestTransmissionRatio(air, fan, Z_range, F_d)
    v_top_range = zeros(size(Z_range));
    for k = 1:length(Z_range)
        vehicle = Vehicle(air, fan, Z_range(k), F_d);
        v_top_range(k) = TopSpeed(vehicle);
    end
    [v_top, k_best] = max(v_top_range);
    if isnan(v_top)
        Z_best = NaN;
    else
        Z_best = Z_range(k_best);
    end
end
