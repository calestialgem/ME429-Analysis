function F_d = DragForce(fileID)
    DragForces = [
            1 0.0056771236;
            2 0.019862027;
            3 0.044653886;
            4 0.072943843;
            5 0.12036393;
            6 0.16252314;
            7 0.23077475;
            8 0.29405199;
            9 0.4075508;
            10 0.46522198;
            11 0.52931894;
            12 0.63026438;
            13 0.80872616;
            14 0.9422376;
            15 1.0776145;
            16 1.2767977;
            17 1.2853626;
            18 1.3097346;
            19 1.5518665;
            20 2.0525466
            ];
    c_d_data = DragForces(:, 2) ./ DragForces(:, 1).^2;
    c_d = mean(c_d_data);
    F_d = @(v_t) c_d * v_t.^2;
    fprintf(fileID, 'Drag Root Mean Square Error: %e\n', sqrt(sum((F_d(DragForces(:, 1)) - DragForces(:, 2)).^2)) / size(DragForces, 1) / (max(DragForces(:, 1)) - min(DragForces(:, 1))));
    v_w_range = 0:0.1:max(DragForces(:, 1));
    figure();
    hold('on');
    grid('on');
    xlabel('v_w (m/s)');
    ylabel('F_d (N)');
    title('Drag Force Fit');
    plot(v_w_range, F_d(v_w_range), 'LineWidth', 2);
    plot(DragForces(:, 1), DragForces(:, 2), 'x', 'LineWidth', 2);
    saveas(gcf, 'Drag Force Fit', 'svg');
end
