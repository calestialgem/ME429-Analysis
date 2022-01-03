% gecgelcem 3.01.2022
% BOUN ME 429 Project

clc();
clear();
close('all');

fan = GetAPC14x7E();
air = Air(5, 1.225);
vehicle = Vehicle(fan, air, 0.2, 0.35, 1);
Vm = fzero(@(V) vehicle.Acceleration(V), 100*air.V);
fprintf('Found Top Speed: %g', Vm);
figure();
hold('on');
grid('on');
xlabel('Speed (m/s)');
ylabel('Acceleration (m/s^2)');
title('Acceleration vs Speed');
Vr = air.V:air.V*0.1:air.V*11.75;
plot(Vr, vehicle.Acceleration(Vr), 'LineWidth', 2);
