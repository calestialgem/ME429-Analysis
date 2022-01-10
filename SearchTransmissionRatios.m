function [Vt, rt, Vb, rb] = SearchTransmissionRatios(vehicle, rr)
	Vminr = zeros(size(rr));
	Vmaxr = zeros(size(rr));
	Vr = zeros(size(rr));
	Vb = -inf;
	for k = 1:length(rr)
		vehicle = vehicle.Setr(rr(k));
		[Vmin, Vmax] = vehicle.SpeedBoundary();
		Vminr(k) = Vmin;
		Vmaxr(k) = Vmax;
		Vr(k) = BisectionMethod(@(V) vehicle.Acceleration(V), Vmin, Vmax*100, 1e-6, 1e3);
		if Vr(k) <= Vmax
			if Vr(k) > Vb
				Vb = Vr(k);
				rb = vehicle.r;
			end
		end
	end
	[Vt, kt] = max(Vr);
	rt = rr(kt);
	figure();
	hold('on');
	grid('on');
	title('Top Speed vs Transmission Ratio');
	xlabel('r');
	ylabel('v_{top} (m/s)');
	plot(rr, Vminr, 'LineWidth', 2);
	plot(rr, Vmaxr, 'LineWidth', 2);
	plot(rr, Vr, 'LineWidth', 2);
	plot(rb, Vb, 'x', 'MarkerSize', 12, 'LineWidth', 2);
	plot(rt, Vt, 'x', 'MarkerSize', 12, 'LineWidth', 2);
	legend('Data Start', 'Data End', 'Top Speed', 'Bounded Best', 'Best', 'Location', 'Best');
end
