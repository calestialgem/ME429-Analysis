function [T, Y] = RungeKuttaMethod(f, N, Tf, y)
	h = Tf/N;
	h2 = h/2;
	h6 = h/6;
	t = 0;
	T = zeros(1, N);
	Y = zeros(1, N);
	Y(1) = y;
	for k = 2:N
		k1 = f(t, y);
		k2 = f(t+h2, y+h2*k1);
		k3 = f(t+h2, y+h2*k2);
		k4 = f(t+h, y+h*k3);
		t = t+h;
		y = y + h6*(k1+2*(k2+k3)+k4);
		T(k) = t;
		Y(k) = y;
	end
end
