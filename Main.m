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
fprintf(fileID, 'd_min=%.4f m d_max=%.4f m d_step=%.4f m\n', d_min, d_max, d_step);

air = Air(5);
[v_top, d_best] = SearchWheelDiameters(air, fan, d_range, F_d);
vehicle = Vehicle(air, fan, d_best, F_d);
v = Simulate(vehicle, 25);
[v_min, v_max] = vehicle.SpeedBoundary();
fprintf(fileID, 'd=%.4f m v_top=%.4fm/s B=[%.4f, %.4f]m/s\n', d_best, v_top, v_min, v_max);

VelocityRelations(vehicle);

SearchWindSpeeds(fan, 1:0.1:10, d_best, 70e-3:d_step:95e-3, F_d);

toc();

if fclose(fileID) ~= 0
	fprintf('Error while closing the file %s!\n', fileName);
end
