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

d = 90e-3;
Z = 1.25;

initial = Parameter(air, fan, drag, @(x) 0, d, Z, true);
revised = Parameter(air, fan, drag, friction, d, Z, true);

t_f = 1.05;
v_real = 5.64;
v_initial = Simulate(initial, t_f, false);
v_revised = Simulate(revised, t_f, false);

e_initial = (v_initial - v_real) / v_real;
e_revised = (v_revised - v_real) / v_real;

fprintf(fileID, "Design:\n");
fprintf(fileID, "* d = %.0f mm\n", d * 1e3);
fprintf(fileID, "* Z = %.2f\n", Z);
fprintf(fileID, "\nAt t = %.2f s\n", t_f);
fprintf(fileID, "\n- v_real    = %10.2f m/s\n", v_real);
fprintf(fileID, "\n- v_initial = %10.2f m/s ; Error = %5.2f%%\n", v_initial, e_initial * 100);
fprintf(fileID, "\n- v_revised = %10.2f m/s ; Error = %5.2f%%\n", v_revised, e_revised * 100);

if fclose(fileID) ~= 0
    fprintf('Error while closing the file %s!\n', fileName);
end
