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

rr = 0.5:0.1:3;
Vr = zeros(size(rr));
for k = 1:length(rr)
	vehicle = vehicle.Setr(rr(k));
	Vr(k) = fzero(@(V) vehicle.Acceleration(V), 100*air.V);
end
figure();
hold('on');
grid('on');
xlabel('Transmission Ratio');
ylabel('Top Speed (m/s)');
title('Top Speed vs Transmission Ratio');
plot(rr, Vr, 'LineWidth', 2);
