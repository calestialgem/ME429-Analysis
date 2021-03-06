function v_f = Simulate(parameter, t_f)
    vehicle = parameter.vehicle(1);
    [v_min, ~] = vehicle.SpeedBoundary();
    [t_range, v_range] = RungeKuttaMethod(@(~, V) vehicle.Acceleration(V), 1e3, t_f, v_min);
    [a_range, ~, F_t_range, F_d_range, F_q_range, F_f_range, F_net_range] = vehicle.Acceleration(v_range);
    v_f = v_range(end);
    if ~isempty(parameter.file_name)
        format = parameter.format(parameter.x(1));
        figure();
        hold('on');
        grid('on');
        plot(t_range, v_range, 'LineWidth', 2);
        xlabel('t (s)');
        ylabel('v (m/s)');
        title(sprintf('Velocity vs Time %s', format));
        saveas(gcf, sprintf('Velocity vs Time %s.jpg', parameter.file_name), 'jpeg');
        figure();
        hold('on');
        grid('on');
        plot(t_range, a_range, 'LineWidth', 2);
        xlabel('t (s)');
        ylabel('a (m/s^2)');
        title(sprintf('Acceleration vs Time %s', format));
        saveas(gcf, sprintf('Acceleration vs Time %s.jpg', parameter.file_name), 'jpeg');
        figure();
        hold('on');
        grid('on');
        plot(t_range, F_t_range, 'LineWidth', 2);
        plot(t_range, F_d_range, 'LineWidth', 2);
        plot(t_range, F_q_range, 'LineWidth', 2);
        legends = ["F_t", "F_d", "F_q"];
        if max(F_f_range) > 0
            plot(t_range, F_f_range, 'LineWidth', 2);
            legends = [legends "F_f"];
        end
        legends = [legends "F_{net}"];
        plot(t_range, F_net_range, 'LineWidth', 2);
        xlabel('t (s)');
        ylabel('F (N)');
        title(sprintf('Forces vs Time %s', format));
        legend(legends, 'Location', 'Best');
        saveas(gcf, sprintf('Forces vs Time %s.jpg', parameter.file_name), 'jpeg');
    end
end
