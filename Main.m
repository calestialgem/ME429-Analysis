% gecgelcem 3.01.2022
% BOUN ME 429 Project

clc();
clear();
close('all');

fan = GetAPC14x7E();
air = Air(5, 1.225);
vehicle = Vehicle(fan, air, 0.2, 0.35, 1);
Vm = fzero(@(V) vehicle.Acceleration(V), 2*air.V);
fprintf('Found Top Speed: %g', Vm);
