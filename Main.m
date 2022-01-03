% gecgelcem 3.01.2022
% BOUN ME 429 Project

clc();
clear();
close('all');

APC19x10E = GetAPC19x10E();
APC19x12E = GetAPC19x12E();

APC19x10E.PlotFitJ();
APC19x10E.PlotFitw();
