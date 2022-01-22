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
fprintf(fileID, fan.RootMeanSquare());

air = Air(5);
[v_top, SR_top] = SearchTransmissionRatios(air, fan, 0.1:0.01:5);
vehicle = Vehicle(air, fan, SR_top);
v = Simulate(vehicle, 100);
[v_min, v_max] = vehicle.SpeedBoundary();
fprintf(fileID, 'SR=%.2f v_top=%.1fm/s B=[%.1f, %.1f]m/s\n', SR_top, v_top, v_min, v_max);

SearchWindSpeeds(fan, 1:0.1:10, 1, 5);

toc();

if fclose(fileID) ~= 0
	fprintf('Error while closing the file %s!\n', fileName);
end
