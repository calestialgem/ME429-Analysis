function friction = Experiments(fileID)
    fan = GetAPC14x7E([]);
    air = Air(20 * 1000/3600);
    V = [10 15 20];
    I_m = [73 78 82] * 1e-3;
    I_l = [98 133 180] * 1e-3;
    w = [609 931 1251] * (2 * pi / 60);
    P = (I_l - I_m) .* V;
    T_q = P ./ w;
    F_t = [11 28.3 53] * 9.81e-3;
    [F_t_f, T_q_f] = fan.Find(air, 0, w);

    n = 0.90;
    Z = 1.25;
    d = 90e-3;
    w_e = air.V / (Z * d / 2);
    F_q = T_q / (n * Z * d / 2);
    F_diff = F_t - F_q;
    for j = 2:length(F_diff)
        if w_e < w(j)
            break;
        end
    end
    F_f_h = F_diff(j - 1) + (F_diff(j) - F_diff(j - 1)) * (w_e - w(j - 1)) / (w(j) - w(j - 1));
    F_f_l = 5 * 9.81e-3;
    friction = @(v) F_f_l + (v / air.V) * (F_f_h - F_f_l);

    if ~isempty(fileID)
        e_t = sqrt(sum((F_t_f - F_t).^2) / length(F_t)) / (max(F_t_f) - min(F_t_f));
        e_q = sqrt(sum((T_q_f - T_q).^2) / length(T_q)) / (max(T_q_f) - min(T_q_f));
        fprintf(fileID, "Experiments: e_t=%.3f%%, e_q=%.3f%%\n", e_t * 100, e_q * 100);

        v_range = 0:air.V * 1.5e-3:air.V * 1.5;

        figure();
        hold('on');
        grid('on');
        xlabel('v (m/s)');
        ylabel('F_f (N)');
        title("Friction Experiments");
        plot(v_range, friction(v_range), 'LineWidth', 2);
        plot([0 air.V], [F_f_l F_f_h], 'x', 'LineWidth', 2);
        legend('Fit', 'Experiment', 'Location', 'Best');
        saveas(gcf, 'Friction Experiments', 'jpeg');

        w_range = 0:max(w) * 1.5e-3:max(w) * 1.5;
        [F_t_range, T_q_range] = fan.Find(air, 0, w_range);

        figure();
        hold('on');
        grid('on');
        xlabel('w (rad/s)');
        ylabel('F_t (N)');
        title("Thrust Experiments");
        plot(w_range, F_t_range, 'LineWidth', 2);
        plot(w, F_t, 'x', 'LineWidth', 2);
        legend('Fit', 'Experiment', 'Location', 'Best');
        saveas(gcf, 'Thrust Experiments', 'jpeg');

        figure();
        hold('on');
        grid('on');
        xlabel('w (rad/s)');
        ylabel('T_q (mN)');
        title("Torque Experiments");
        plot(w_range, T_q_range, 'LineWidth', 2);
        plot(w, T_q, 'x', 'LineWidth', 2);
        legend('Fit', 'Experiment', 'Location', 'Best');
        saveas(gcf, 'Torque Experiments', 'jpeg');
    end
end
