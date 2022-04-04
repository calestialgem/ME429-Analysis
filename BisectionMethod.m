function c = BisectionMethod(f, a, b, t, I)
	ya = f(a);
	yb = f(b);
	if ya*yb>0
		c = NaN;
		return
	elseif ya==0
		c = a;
		return
	elseif yb==0
		c = b;
		return
	end
	for k = 1:I
		c = (a+b)/2;
		if c-a < t || b-c < t
			return
		end
		yc = f(c);
		if yc > -t && yc < t
			return;
		end
		if ya*yc > 0
			a = c;
			ya = yc;
		else
			b = c;
		end
	end
	c = NaN;
end
