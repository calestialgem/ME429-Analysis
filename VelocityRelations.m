function v_range = VelocityRelations(parameter)
    vehicle = parameter.vehicle(1);
    [v_min, v_max] = vehicle.SpeedBoundary();
    v_range = v_min:(v_max - v_min) / 1e3:v_max;
    [a_range, ~, F_t_range, F_d_range, F_q_range, F_f_range, F_net_range] = vehicle.Acceleration(v_range);
    [~, k_top] = min(abs(a_range));
    if a_range(k_top) < 0
        k_top = k_top - 1;
    end
    k_range = 1:k_top;
    if ~isempty(parameter.file_name)
        format = parameter.format(parameter.x(1));
        figure();
        hold('on');
        grid('on');
        plot(v_range(k_range), a_range(k_range), 'LineWidth', 2);
        ylabel('a (m/s^2)');
        xlabel('v (m/s)');
        title(sprintf('Acceleration vs Velocity %s', format));
        saveas(gcf, sprintf('Acceleration vs Velocity %s.jpg', parameter.file_name), 'jpeg');
        figure();
        hold('on');
        grid('on');
        plot(v_range(k_range), F_t_range(k_range), 'LineWidth', 2);
        plot(v_range(k_range), F_d_range(k_range), 'LineWidth', 2);
        plot(v_range(k_range), F_q_range(k_range), 'LineWidth', 2);
        legends = ["F_t", "F_d", "F_q"];
        if max(F_f_range) > 0
            plot(v_range(k_range), F_f_range(k_range), 'LineWidth', 2);
            legends = [legends "F_f"];
        end
        legends = [legends "F_{net}"];
        plot(v_range(k_range), F_net_range(k_range), 'LineWidth', 2);
        ylabel('F (N)');
        xlabel('v (m/s)');
        title(sprintf('Forces vs Velocity %s', format));
        legend(legends, 'Location', 'Best');
        saveas(gcf, sprintf('Forces vs Velocity %s.jpg', parameter.file_name), 'jpeg');
    end
end
