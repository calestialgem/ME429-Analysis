% gecgelcem 3.01.2022
% BOUN ME 429 Project

clc();
clear();
close('all');

fan = GetAPC14x7E();
air = Air(5, 1.225);
vehicle = Vehicle(fan, air, 0.2, 0.35, 1);
