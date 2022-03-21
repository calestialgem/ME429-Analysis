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

Z_min = 0.1;
Z_max = 5;
Z_step = 0.01;
Z_range = Z_min:Z_step:Z_max;
fprintf(fileID, 'Z_min=%.2f Z_max=%.2f Z_step=%.2f\n', Z_min, Z_max, Z_step);

air = Air(5);
[v_top, Z_best] = SearchTransmissionRatios(air, fan, Z_range, F_d);
vehicle = Vehicle(air, fan, Z_best, F_d);
v = Simulate(vehicle, 25);
[v_min, v_max] = vehicle.SpeedBoundary();
fprintf(fileID, 'Z=%.2f v_top=%.1fm/s B=[%.1f, %.1f]m/s\n', Z_best, v_top, v_min, v_max);

VelocityRelations(vehicle);

SearchWindSpeeds(fan, 1:0.1:10, Z_best, Z_min, Z_max, F_d);

toc();

if fclose(fileID) ~= 0
	fprintf('Error while closing the file %s!\n', fileName);
end
