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

tic();

parameter = Parameter(Air(5), GetAPC14x7E(fileID), DragForce(fileID), Experiments(fileID), 90e-3, 0.5:0.01:2, true);

fprintf(fileID, '%s %s %s\n', parameter.subscript(parameter.x(1), 'min'), parameter.subscript(parameter.range(end), 'max'), parameter.subscript(parameter.x(2) - parameter.x(1), 'step'));

[v_top, x_best] = SearchParameter(parameter);
fixed_parameter = Parameter(parameter.air, parameter.fan, parameter.F_d, parameter.F_f, parameter.fixed, x_best, parameter.parameter);
v = Simulate(fixed_parameter, 30);
[v_min, v_max] = fixed_parameter.vehicle(1).SpeedBoundary();
fprintf(fileID, 'Z=%.3f mm v_top=%.3fm/s B=[%.3f, %.3f]m/s\n', x_best, v_top, v_min, v_max);

VelocityRelations(fixed_parameter);
SearchWindSpeeds(parameter, fixed_parameter, 1:0.1:10);

toc();

if fclose(fileID) ~= 0
    fprintf('Error while closing the file %s!\n', fileName);
end
