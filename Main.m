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
frictionless = Frictionless();

analyze(fileID, Parameter("Initial", air, fan, drag, frictionless, 1, 70e-3:1e-3:82e-3, false))
analyze(fileID, Parameter("Improved", air, fan, drag, friction, 90e-3, 78e-2:1e-2:92e-2, true))
analyze(fileID, Parameter("Revised", air, fan, drag, friction, 1, 70e-3:1e-3:82e-3, false))

if fclose(fileID) ~= 0
    fprintf('Error while closing the file %s!\n', fileName);
end

function analyze(fileID, parameter)
    start = tic();

    if ~isempty(fileID)
        fprintf(fileID, '\n________________________________________________________________________________\n');
        fprintf(fileID, 'Fixed %s %s\n', parameter.name(), parameter.file_name);
        fprintf(fileID, '%s %s %s\n', parameter.subscript(parameter.x(1), 'min'), parameter.subscript(parameter.range(end), 'max'), parameter.subscript(parameter.x(2) - parameter.x(1), 'step'));
    end

    [v_top, x_best] = SearchParameter(parameter);
    fixed_parameter = parameter;
    fixed_parameter.range = x_best;

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
