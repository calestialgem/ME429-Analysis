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

air = Air(5, 1.225);
fan = GetAPC14x7E(air);
% fan.PlotFitw();
% fan.PlotFitJ();
fprintf(fileID, fan.RootMeanSquare());

[Vt, rt] = SearchTransmissionRatios(air, fan, 0.1:0.01:5);
vehicle = Vehicle(air, fan, rt);
fan.PlotFitTQ(vehicle);
v = Simulate(vehicle, 100);
[Vmin, Vmax] = vehicle.SpeedBoundary();
fprintf(fileID, 't=%.2f Vt=%.1fm/s B=[%.1f, %.1f]m/s\n', rt, Vt, Vmin, Vmax);

if fclose(fileID) ~= 0
	fprintf('Error while closing the file %s!\n', fileName);
end
