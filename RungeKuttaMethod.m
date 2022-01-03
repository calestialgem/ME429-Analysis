function [Y, T] = RungeKuttaMethod(f, y, Tf, N)
	h = Tf/N;
	t = 0;
	Y = zeros(1, N);
	T = zeros(1, N);
	Y(1) = y;
	for k = 2:N
		f1 = f(t, y);
		f2 = f(t+h/2, y+f1/2);
		f3 = f(t+h/2, y+f2/2);
		f4 = f(t+h, y+f3);
		t = t+h;
		y = y + h/6*(f1+2*(f2+f3)+f4);
		T(k) = t;
		Y(k) = y;
	end
end
