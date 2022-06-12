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

p = 1;

analyze(fileID, Parameter("Initial", air, fan, drag, frictionless, 1, 50e-3:1e-3 / p:200e-3, false), 77e-3:1e-3 / p:91e-3);
analyze(fileID, Parameter("Improved", air, fan, drag, friction, 90e-3, 50e-2:1e-2 / p:200e-2, true), 82e-2:1e-2 / p:92e-2);
analyze(fileID, Parameter("Revised", air, fan, drag, friction, 1, 50e-3:1e-3 / p:200e-3, false), 74e-3:1e-3 / p:83e-3);

if fclose(fileID) ~= 0
    fprintf('Error while closing the file %s!\n', fileName);
end

function analyze(fileID, parameter, wind_search_range)
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
    parameter.range = wind_search_range;
    SearchWindSpeeds(parameter, fixed_parameter, 3:0.1:8);

    if ~isempty(fileID)
        fprintf(fileID, 'Elapsed Time: %.1f s', toc(start));
    end
end
