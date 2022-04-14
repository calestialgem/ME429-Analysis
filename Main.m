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

fan = GetAPC14x7E();
fan.PlotFitJ();
fan.PlotFitw();
fprintf(fileID, fan.RootMeanSquare());

F_d = DragForce(fileID);

d_min = 10e-3;
d_max = 1000e-3;
d_step = 0.1e-3;
d_range = d_min:d_step:d_max;
fprintf(fileID, 'd_min=%.1f mm d_max=%.1f mm d_step=%.1f mm\n', 1e3*d_min, 1e3*d_max, 1e3*d_step);

air = Air(5);
[v_top, d_best] = SearchWheelDiameters(air, fan, d_range, F_d);
vehicle = Vehicle(air, fan, d_best, F_d);
v = Simulate(vehicle, 30);
[v_min, v_max] = vehicle.SpeedBoundary();
fprintf(fileID, 'd=%.1f mm v_top=%.3fm/s B=[%.3f, %.3f]m/s\n', 1e3*d_best, v_top, v_min, v_max);

VelocityRelations(vehicle);

SearchWindSpeeds(fan, 1:0.1:10, d_best, 70e-3:d_step:95e-3, F_d);

toc();

if fclose(fileID) ~= 0
	fprintf('Error while closing the file %s!\n', fileName);
end
