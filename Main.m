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

[Vt, rt, Vb, rb] = SearchTransmissionRatios(Vehicle(fan, air, 0.2, 0.35, 1), 0.5:0.01:3);
[Vminb, Vmaxb] = vehicle.Setr(rb).SpeedBoundary();
[Vmint, Vmaxt] = vehicle.Setr(rt).SpeedBoundary();
fprintf('Best Bounded  r=%.2f Vt=%.1fm/s B=[%.1f, %.1f]m/s\n', rb, Vb, Vminb, Vmaxb);
fprintf('Best Ubounded r=%.2f Vt=%.1fm/s B=[%.1f, %.1f]m/s\n', rt, Vt, Vmint, Vmaxt);
