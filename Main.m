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

fan = GetAPC14x7E();
fan.PlotFitw();
fan.PlotFitJ();
fprintf(fileID, fan.RootMeanSquare());
air = Air(5);
vehicle = Vehicle(fan, air, 1);

[Vt, rt] = SearchTransmissionRatios(vehicle, 0.5:0.01:3);
vehicle = vehicle.Setr(rt);
v = Simulate(vehicle, 100);
[Vmin, Vmax] = vehicle.SpeedBoundary();
fprintf(fileID, 'r=%.2f Vt=%.1fm/s B=[%.1f, %.1f]m/s\n', rt, Vt, Vmin, Vmax);

if fclose(fileID) ~= 0
	fprintf('Error while closing the file %s!\n', fileName);
end
