function SearchWindSpeeds(parameter, fixed_parameter, v_w_range)
    x_best_range = zeros(size(v_w_range));
    v_top_range = zeros(size(v_w_range));
    v_fixed_range = zeros(size(v_w_range));
    for k = 1:length(v_w_range)
        parameter.air = Air(v_w_range(k));
        fixed_parameter.air = parameter.air;
        [x_best, v_top] = BestParameter(parameter);
        x_best_range(k) = x_best;
        v_top_range(k) = v_top;
        v_fixed_range(k) = TopSpeed(fixed_parameter.vehicle(1));
    end
    if ~isempty(parameter.file_name)
        x_title = sprintf('Best %s vs Wind Speed', parameter.name());
        figure();
        hold('on');
        grid('on');
        title(x_title);
        xlabel('v_w (m/s)');
        ylabel(parameter.best_label());
        plot(v_w_range, x_best_range, 'LineWidth', 2);
        saveas(gcf, sprintf("%s %s.jpg", x_title, parameter.file_name), 'jpeg');
        figure();
        hold('on');
        grid('on');
        title('Top Speed vs Wind Speed');
        xlabel('v_w (m/s)');
        ylabel('v_{top} (m/s)');
        plot(v_w_range, v_top_range, 'LineWidth', 2);
        plot(v_w_range, v_fixed_range, 'LineWidth', 2);
        legend(sprintf('%s=%s_{best}(v_w)', parameter.symbol(), parameter.symbol()), parameter.format(fixed_parameter.x(1)), 'Location', 'Best');
        saveas(gcf, sprintf("Top Speed vs Wind Speed %s.jpg", parameter.file_name), 'jpeg');
    end
end
