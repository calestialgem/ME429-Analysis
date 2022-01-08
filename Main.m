% gecgelcem 3.01.2022
% BOUN ME 429 Project

clc();
clear();
close('all');

fileName = 'Simulate.txt';
[fileID, errmsg] = fopen(fileName, 'w');
if ~isempty(errmsg)
	fprintf('File %s Error Message: %s\n', fileName, errmsg);
end

fan = GetAPC14x7E();
air = Air(5, 1.225);
vehicle = Vehicle(fan, air, 350e-3, 0.35, 1.52);
v = Simulate(vehicle, 20);
[Vmin, Vmax] = vehicle.SpeedBoundary();
fprintf(fileID, 'r=%.2f Vt=%.1fm/s B=[%.1f, %.1f]m/s\n', vehicle.r, max(v), Vmin, Vmax);

if fclose(fileID) ~= 0
	fprintf('Error while closing the file %s!\n', fileName);
end
