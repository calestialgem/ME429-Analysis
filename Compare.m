% gecgelcem 12.6.2022
% BOUN ME 492 Project

clc();
clear();
close('all');

fileName = 'Comparison.txt';
[fileID, errmsg] = fopen(fileName, 'w');
if ~isempty(errmsg)
    fprintf('File %s Error Message: %s\n', fileName, errmsg);
end

air = Air(20 * 1000/3600);
fan = GetAPC14x7E([]);
drag = DragForce([]);
friction = Experiments([]);
frictionless = Frictionless();

d = 90e-3;
Z = 1.25;

initial = Parameter([], air, fan, drag, frictionless, d, Z, true);
revised = Parameter([], air, fan, drag, friction, d, Z, true);

t_f = 1.05;
v_real = 5.64;
v_initial = Simulate(initial, t_f);
v_revised = Simulate(revised, t_f);

v_top_initial = TopSpeed(initial.vehicle(1));
v_top_revised = TopSpeed(revised.vehicle(1));

e_initial = (v_initial - v_real) / v_real;
e_revised = (v_revised - v_real) / v_real;

fprintf(fileID, "Design:\n");
fprintf(fileID, "d     = %5.2f mm\n", d * 1e3);
fprintf(fileID, "Z     = %5.2f\n", Z);
fprintf(fileID, "t_f   = %5.2f s\n", t_f);
fprintf(fileID, "v_f   = %5.2f m/s\n", v_real);

fprintf(fileID, "\nInitial Analysis:\n");
fprintf(fileID, "v_f   = %5.2f m/s\n", v_initial);
fprintf(fileID, "e     = %5.2f %%\n", e_initial * 100);
fprintf(fileID, "v_top = %5.2f m/s\n", v_top_initial);
fprintf(fileID, "rel   = %5.2f\n", v_top_initial / air.V);

fprintf(fileID, "\nRevised Analysis:\n");
fprintf(fileID, "v_f   = %5.2f m/s\n", v_revised);
fprintf(fileID, "e     = %5.2f %%\n", e_revised * 100);
fprintf(fileID, "v_top = %5.2f m/s\n", v_top_revised);
fprintf(fileID, "rel   = %5.2f\n", v_top_revised / air.V);

if fclose(fileID) ~= 0
    fprintf('Error while closing the file %s!\n', fileName);
end
