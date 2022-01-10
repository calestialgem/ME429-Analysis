function [Vt, rt] = SearchTransmissionRatios(vehicle, rr)
	Vr = zeros(size(rr));
	for k = 1:length(rr)
		vehicle = vehicle.Setr(rr(k));
		[Vmin, Vmax] = vehicle.SpeedBoundary();
		Vr(k) = BisectionMethod(@(V) vehicle.Acceleration(V), Vmin, Vmax, 1e-6, 1e3);
	end
	[Vt, kt] = max(Vr);
	rt = rr(kt);
	figure();
	hold('on');
	grid('on');
	title('Top Speed vs Transmission Ratio');
	xlabel('r');
	ylabel('v_{top} (m/s)');
	plot(rr, Vr, 'LineWidth', 2);
end
