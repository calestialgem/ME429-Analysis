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
air = Air(5, 1.225);

vehicle = Vehicle(fan, air, 1);
Vt = fzero(@(V) vehicle.Acceleration(V), 100*air.V);
[Vmin, Vmax] = vehicle.SpeedBoundary();
fprintf(fileID, 'r=1 Vt=%.1fm/s B=[%.1f, %.1f]m/s\n', Vt, Vmin, Vmax);

[Vt, rt, Vb, rb] = SearchTransmissionRatios(Vehicle(fan, air, 1), 0.5:0.01:3);
[Vminb, Vmaxb] = vehicle.Setr(rb).SpeedBoundary();
[Vmint, Vmaxt] = vehicle.Setr(rt).SpeedBoundary();
fprintf(fileID, 'Best Bounded  r=%.2f Vt=%.1fm/s B=[%.1f, %.1f]m/s\n', rb, Vb, Vminb, Vmaxb);
fprintf(fileID, 'Best Ubounded r=%.2f Vt=%.1fm/s B=[%.1f, %.1f]m/s\n', rt, Vt, Vmint, Vmaxt);

vehicle = Vehicle(fan, air, 1.502);
v = Simulate(vehicle, 60);
[Vmin, Vmax] = vehicle.SpeedBoundary();
fprintf(fileID, 'r=%.2f Vt=%.1fm/s B=[%.1f, %.1f]m/s\n', vehicle.r, max(v), Vmin, Vmax);

if fclose(fileID) ~= 0
	fprintf('Error while closing the file %s!\n', fileName);
end
