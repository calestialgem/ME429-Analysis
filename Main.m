% gecgelcem 3.01.2022
% BOUN ME 429 Project

clc();
clear();
close('all');

fan = GetAPC14x7E();
air = Air(5, 1.225);
vehicle = Vehicle(fan, air, 0.2, 0.35, 1);
Vt = fzero(@(V) vehicle.Acceleration(V), 100*air.V);
[Vmin, Vmax] = vehicle.SpeedBoundary();
fprintf('r=1 Vt=%.1fm/s B=[%.1f, %.1f]m/s\n', Vt, Vmin, Vmax);

rr = 0.5:0.01:3;

[Vt, rt] = TransmissionRatioSearch(vehicle, rr, 1);
vehicle = vehicle.Setr(rt);
[Vmin, Vmax] = vehicle.SpeedBoundary();
fprintf('Best Bounded r=%.2f Vt=%.1fm/s B=[%.1f, %.1f]m/s\n', vehicle.r, Vt, Vmin, Vmax);
title('Bounded Top Speed vs Transmission Ratio');

[Vt, rt] = TransmissionRatioSearch(vehicle, rr, 10);
vehicle = vehicle.Setr(rt);
[Vmin, Vmax] = vehicle.SpeedBoundary();
fprintf('Best Unbounded r=%.2f Vt=%.1fm/s B=[%.1f, %.1f]m/s\n', vehicle.r, Vt, Vmin, Vmax);
title('Unbounded Top Speed vs Transmission Ratio');

function [Vt, rt] = TransmissionRatioSearch(vehicle, rr, boundMultiplier)
	Vr = zeros(size(rr));
	for k = 1:length(rr)
		vehicle = vehicle.Setr(rr(k));
		[Vmin, Vmax] = vehicle.SpeedBoundary();
		Vr(k) = BisectionMethod(@(V) vehicle.Acceleration(V), Vmin, Vmax*boundMultiplier, 1e-6, 1e3);
	end
	[Vt, kt] = max(Vr);
	rt = rr(kt);
	figure();
	hold('on');
	grid('on');
	xlabel('Transmission Ratio');
	ylabel('Top Speed (m/s)');
	plot(rr, Vr, 'LineWidth', 2);
end
