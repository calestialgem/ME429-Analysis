% gecgelcem 3.01.2022
% BOUN ME 429 Project

clc();
clear();
close('all');

fileName = 'Output.txt';
[fileID, errmsg] = fopen(fileName, 'w');
if ~isempty(errmsg)
    fprintf('File %s Error Message: %s\n', fileName, errmsg);
end

air = Air(5);
fan = GetAPC14x7E(fileID);
drag = DragForce(fileID);
friction = Experiments(fileID);

analyze(fileID, Parameter(air, fan, drag, friction, 90e-3, 0.5:0.001:2, true))
analyze(fileID, Parameter(air, fan, drag, friction, 1, 70e-3:0.1e-3:90e-3, false))

if fclose(fileID) ~= 0
    fprintf('Error while closing the file %s!\n', fileName);
end

function analyze(fileID, parameter)
    start = tic();

    if ~isempty(fileID)
        fprintf(fileID, '\n________________________________________________________________________________\n');
        fprintf(fileID, 'Fixed %s %s\n', parameter.name(), parameter.file_name());
        fprintf(fileID, '%s %s %s\n', parameter.subscript(parameter.x(1), 'min'), parameter.subscript(parameter.range(end), 'max'), parameter.subscript(parameter.x(2) - parameter.x(1), 'step'));
    end

    [v_top, x_best] = SearchParameter(parameter);
    fixed_parameter = Parameter(parameter.air, parameter.fan, parameter.F_d, parameter.F_f, parameter.fixed, x_best, parameter.parameter);

    Simulate(fixed_parameter, 30);

    if ~isempty(fileID)
        [v_min, v_max] = fixed_parameter.vehicle(1).SpeedBoundary();
        fprintf(fileID, '%s v_top=%.3fm/s B=[%.3f, %.3f]m/s\n', parameter.format(x_best), v_top, v_min, v_max);
    end

    VelocityRelations(fixed_parameter);
    SearchWindSpeeds(parameter, fixed_parameter, 1:0.1:10);

    if ~isempty(fileID)
        fprintf(fileID, 'Elapsed Time: %.1f s', toc(start));
    end
end
