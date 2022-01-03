classdef Fan
	properties
		J_data
		w_data
		Ct_data
		Cq_data
		Ct
		Cq
	end
	methods
		function self = Fan(J_data, w_data, Ct_data, Cq_data)
			self.J_data = J_data ./ (2*pi);
			self.w_data = w_data .* (2*pi/60);
			self.Ct_data = Ct_data ./ (2*pi)^2;
			self.Cq_data = Cq_data ./ (2*pi)^3;
		end
		function [T, Q] = Find(self, rho, J, w)
		end
	end
	methods(Static)
		function Fan = Get19x10E()
			J_data = [0.00 0.03 0.05 0.08 0.10 0.13 0.15 0.18 0.20 0.23 0.25 0.28 0.30 0.33 0.35 0.38 0.40 0.43 0.45 0.48 0.50 0.53 0.55 0.58 0.60 0.63 0.65 0.68 0.70 0.73];
			w_data = [1000 2000 3000 4000 5000 6000 7000 8000 9000];
			Ct_data = [
				0.0913 0.0904 0.0894 0.0881 0.0867 0.0851 0.0833 0.0814 0.0792 0.0769 0.0744 0.0717 0.0689 0.0658 0.0625 0.0590 0.0553 0.0516 0.0477 0.0438 0.0398 0.0357 0.0315 0.0272 0.0228 0.0184 0.0139 0.0093 0.0047 0.0000;
				0.0914 0.0906 0.0896 0.0883 0.0869 0.0853 0.0835 0.0816 0.0795 0.0771 0.0746 0.0720 0.0691 0.0660 0.0627 0.0592 0.0555 0.0517 0.0479 0.0440 0.0400 0.0358 0.0316 0.0273 0.0230 0.0185 0.0140 0.0094 0.0047 0.0000;
				0.0914 0.0906 0.0896 0.0883 0.0870 0.0854 0.0836 0.0816 0.0795 0.0772 0.0747 0.0720 0.0692 0.0661 0.0628 0.0593 0.0556 0.0518 0.0480 0.0440 0.0400 0.0359 0.0317 0.0274 0.0230 0.0185 0.0140 0.0094 0.0047 0.0000;
				0.0932 0.0923 0.0913 0.0900 0.0885 0.0869 0.0850 0.0829 0.0807 0.0783 0.0757 0.0729 0.0699 0.0667 0.0634 0.0598 0.0561 0.0523 0.0484 0.0444 0.0403 0.0361 0.0319 0.0276 0.0232 0.0187 0.0141 0.0095 0.0048 0.0000;
				0.0952 0.0944 0.0933 0.0920 0.0904 0.0886 0.0867 0.0845 0.0822 0.0796 0.0769 0.0740 0.0709 0.0676 0.0641 0.0605 0.0567 0.0529 0.0489 0.0449 0.0408 0.0366 0.0323 0.0279 0.0235 0.0189 0.0143 0.0096 0.0048 0.0000;
				0.0971 0.0964 0.0955 0.0941 0.0925 0.0906 0.0886 0.0863 0.0838 0.0812 0.0784 0.0753 0.0721 0.0687 0.0651 0.0613 0.0575 0.0536 0.0496 0.0455 0.0413 0.0371 0.0327 0.0283 0.0238 0.0192 0.0145 0.0097 0.0049 0.0000;
				0.0967 0.0963 0.0957 0.0947 0.0932 0.0914 0.0894 0.0872 0.0848 0.0822 0.0794 0.0764 0.0732 0.0698 0.0663 0.0625 0.0586 0.0546 0.0505 0.0464 0.0421 0.0378 0.0334 0.0289 0.0243 0.0196 0.0148 0.0099 0.0050 0.0000;
				0.0956 0.0955 0.0952 0.0949 0.0940 0.0925 0.0906 0.0885 0.0861 0.0836 0.0808 0.0779 0.0747 0.0714 0.0678 0.0640 0.0600 0.0559 0.0518 0.0475 0.0432 0.0387 0.0342 0.0296 0.0249 0.0201 0.0152 0.0102 0.0051 0.0000;
				0.0946 0.0946 0.0945 0.0945 0.0944 0.0942 0.0927 0.0906 0.0884 0.0858 0.0831 0.0802 0.0770 0.0736 0.0700 0.0661 0.0620 0.0579 0.0536 0.0492 0.0447 0.0401 0.0355 0.0307 0.0259 0.0209 0.0158 0.0106 0.0054 0.0000;
			];
			Cq_data = [
				0.0350 0.0354 0.0357 0.0360 0.0362 0.0364 0.0365 0.0366 0.0366 0.0366 0.0364 0.0362 0.0359 0.0355 0.0349 0.0342 0.0333 0.0322 0.0311 0.0297 0.0281 0.0262 0.0242 0.0219 0.0193 0.0166 0.0137 0.0106 0.0074 0.0045;
				0.0347 0.0351 0.0355 0.0358 0.0360 0.0363 0.0364 0.0365 0.0365 0.0365 0.0363 0.0361 0.0358 0.0353 0.0347 0.0339 0.0330 0.0319 0.0307 0.0293 0.0277 0.0259 0.0239 0.0216 0.0191 0.0164 0.0135 0.0104 0.0073 0.0044;
				0.0325 0.0331 0.0336 0.0340 0.0345 0.0348 0.0351 0.0352 0.0353 0.0353 0.0352 0.0349 0.0346 0.0340 0.0334 0.0325 0.0315 0.0303 0.0290 0.0276 0.0260 0.0243 0.0224 0.0202 0.0179 0.0154 0.0127 0.0098 0.0068 0.0041;
				0.0434 0.0425 0.0415 0.0406 0.0399 0.0392 0.0386 0.0380 0.0374 0.0369 0.0363 0.0356 0.0349 0.0341 0.0333 0.0323 0.0312 0.0300 0.0287 0.0272 0.0256 0.0238 0.0219 0.0197 0.0174 0.0149 0.0122 0.0094 0.0064 0.0038;
				0.0547 0.0523 0.0498 0.0475 0.0454 0.0436 0.0421 0.0408 0.0397 0.0386 0.0375 0.0365 0.0355 0.0345 0.0334 0.0323 0.0312 0.0300 0.0286 0.0271 0.0254 0.0236 0.0216 0.0194 0.0171 0.0146 0.0119 0.0090 0.0060 0.0035;
				0.0667 0.0627 0.0587 0.0549 0.0512 0.0482 0.0457 0.0437 0.0420 0.0404 0.0389 0.0376 0.0363 0.0350 0.0338 0.0326 0.0314 0.0301 0.0287 0.0271 0.0254 0.0235 0.0215 0.0193 0.0169 0.0144 0.0117 0.0088 0.0058 0.0033;
				0.0601 0.0573 0.0545 0.0516 0.0488 0.0461 0.0440 0.0424 0.0411 0.0399 0.0387 0.0376 0.0365 0.0355 0.0344 0.0332 0.0320 0.0307 0.0292 0.0276 0.0258 0.0239 0.0218 0.0196 0.0172 0.0146 0.0118 0.0089 0.0057 0.0032;
				0.0491 0.0481 0.0471 0.0460 0.0448 0.0434 0.0420 0.0410 0.0402 0.0395 0.0388 0.0380 0.0371 0.0362 0.0352 0.0341 0.0329 0.0315 0.0300 0.0283 0.0265 0.0245 0.0224 0.0200 0.0176 0.0149 0.0120 0.0089 0.0057 0.0032;
				0.0361 0.0368 0.0376 0.0384 0.0392 0.0400 0.0402 0.0402 0.0400 0.0398 0.0394 0.0389 0.0382 0.0374 0.0365 0.0354 0.0341 0.0327 0.0311 0.0294 0.0275 0.0254 0.0231 0.0207 0.0182 0.0154 0.0124 0.0092 0.0059 0.0033;
			];
			Fan = Fan(J_data, w_data, Ct_data, Cq_data);
		end
		function Fan = Get19x12E()
			J_data = [0.00 0.03 0.06 0.09 0.12 0.15 0.17 0.20 0.23 0.26 0.29 0.32 0.35 0.38 0.41 0.44 0.46 0.49 0.52 0.55 0.58 0.61 0.64 0.67 0.70 0.73 0.76 0.78 0.81 0.84];
			w_data = [1000 2000 3000 4000 5000 6000 7000 8000 9000];
			Ct_data = [
				0.0943 0.0942 0.0940 0.0937 0.0932 0.0925 0.0915 0.0901 0.0884 0.0863 0.0839 0.0813 0.0784 0.0752 0.0717 0.0680 0.0639 0.0596 0.0551 0.0506 0.0459 0.0412 0.0364 0.0314 0.0264 0.0212 0.0160 0.0107 0.0054 0.0000;
				0.0943 0.0941 0.0940 0.0937 0.0933 0.0926 0.0916 0.0903 0.0885 0.0865 0.0841 0.0815 0.0786 0.0754 0.0719 0.0682 0.0641 0.0598 0.0553 0.0507 0.0461 0.0413 0.0365 0.0315 0.0265 0.0213 0.0161 0.0108 0.0054 0.0000;
				0.0940 0.0939 0.0937 0.0935 0.0931 0.0924 0.0915 0.0902 0.0885 0.0865 0.0842 0.0816 0.0787 0.0755 0.0720 0.0683 0.0643 0.0599 0.0554 0.0508 0.0462 0.0414 0.0366 0.0316 0.0265 0.0214 0.0162 0.0109 0.0055 0.0000;
				0.0966 0.0964 0.0962 0.0959 0.0955 0.0948 0.0938 0.0923 0.0905 0.0883 0.0858 0.0830 0.0799 0.0765 0.0729 0.0690 0.0648 0.0604 0.0559 0.0513 0.0466 0.0417 0.0368 0.0318 0.0268 0.0216 0.0163 0.0110 0.0055 0.0000;
				0.0991 0.0989 0.0987 0.0984 0.0980 0.0973 0.0963 0.0948 0.0928 0.0904 0.0876 0.0846 0.0814 0.0778 0.0740 0.0699 0.0656 0.0611 0.0565 0.0519 0.0471 0.0422 0.0373 0.0322 0.0271 0.0218 0.0165 0.0111 0.0056 0.0000;
				0.1014 0.1012 0.1010 0.1007 0.1002 0.0996 0.0987 0.0972 0.0952 0.0926 0.0897 0.0865 0.0831 0.0793 0.0753 0.0711 0.0666 0.0620 0.0574 0.0526 0.0478 0.0429 0.0378 0.0327 0.0275 0.0222 0.0168 0.0112 0.0056 0.0000;
				0.0997 0.0996 0.0995 0.0992 0.0989 0.0985 0.0980 0.0971 0.0955 0.0932 0.0905 0.0874 0.0840 0.0804 0.0765 0.0723 0.0679 0.0632 0.0585 0.0537 0.0487 0.0437 0.0386 0.0333 0.0280 0.0226 0.0171 0.0115 0.0058 0.0000;
				0.0974 0.0973 0.0973 0.0972 0.0970 0.0969 0.0966 0.0963 0.0957 0.0940 0.0915 0.0886 0.0854 0.0819 0.0781 0.0740 0.0696 0.0648 0.0600 0.0551 0.0500 0.0449 0.0396 0.0343 0.0288 0.0233 0.0176 0.0118 0.0060 0.0000;
				0.0951 0.0951 0.0951 0.0952 0.0952 0.0952 0.0952 0.0951 0.0951 0.0949 0.0936 0.0909 0.0878 0.0843 0.0806 0.0764 0.0720 0.0671 0.0622 0.0571 0.0519 0.0466 0.0412 0.0356 0.0300 0.0242 0.0184 0.0124 0.0062 0.0000;
			];
			Cq_data = [
				0.0403 0.0410 0.0418 0.0426 0.0433 0.0440 0.0445 0.0449 0.0452 0.0453 0.0453 0.0451 0.0448 0.0444 0.0438 0.0430 0.0419 0.0406 0.0390 0.0373 0.0353 0.0330 0.0304 0.0275 0.0242 0.0206 0.0167 0.0126 0.0083 0.0043;
				0.0397 0.0405 0.0413 0.0421 0.0429 0.0436 0.0442 0.0447 0.0450 0.0451 0.0451 0.0450 0.0447 0.0443 0.0437 0.0428 0.0417 0.0403 0.0388 0.0370 0.0350 0.0327 0.0300 0.0271 0.0238 0.0203 0.0165 0.0125 0.0081 0.0043;
				0.0361 0.0371 0.0382 0.0393 0.0403 0.0413 0.0422 0.0428 0.0433 0.0437 0.0439 0.0438 0.0436 0.0432 0.0425 0.0416 0.0404 0.0389 0.0373 0.0354 0.0333 0.0310 0.0285 0.0257 0.0226 0.0193 0.0157 0.0118 0.0077 0.0040;
				0.0596 0.0584 0.0572 0.0560 0.0547 0.0534 0.0520 0.0506 0.0493 0.0481 0.0471 0.0462 0.0452 0.0442 0.0430 0.0418 0.0404 0.0388 0.0371 0.0351 0.0330 0.0306 0.0281 0.0253 0.0221 0.0188 0.0153 0.0114 0.0073 0.0037;
				0.0828 0.0796 0.0764 0.0730 0.0696 0.0660 0.0624 0.0589 0.0555 0.0527 0.0506 0.0487 0.0470 0.0454 0.0438 0.0423 0.0406 0.0389 0.0372 0.0352 0.0330 0.0305 0.0279 0.0251 0.0219 0.0186 0.0150 0.0111 0.0069 0.0034;
				0.1055 0.1006 0.0953 0.0900 0.0846 0.0790 0.0733 0.0677 0.0623 0.0576 0.0539 0.0512 0.0489 0.0468 0.0448 0.0429 0.0411 0.0393 0.0375 0.0354 0.0332 0.0307 0.0280 0.0250 0.0219 0.0185 0.0149 0.0109 0.0067 0.0032;
				0.0894 0.0861 0.0826 0.0790 0.0752 0.0714 0.0675 0.0636 0.0596 0.0557 0.0526 0.0504 0.0486 0.0469 0.0453 0.0436 0.0419 0.0401 0.0382 0.0361 0.0338 0.0312 0.0285 0.0255 0.0222 0.0187 0.0150 0.0110 0.0067 0.0032;
				0.0657 0.0645 0.0632 0.0619 0.0606 0.0592 0.0578 0.0564 0.0549 0.0532 0.0511 0.0497 0.0485 0.0474 0.0460 0.0446 0.0431 0.0412 0.0393 0.0371 0.0347 0.0321 0.0292 0.0261 0.0228 0.0192 0.0154 0.0112 0.0068 0.0032;
				0.0400 0.0409 0.0418 0.0428 0.0437 0.0447 0.0458 0.0469 0.0481 0.0493 0.0499 0.0497 0.0493 0.0486 0.0476 0.0463 0.0447 0.0429 0.0408 0.0385 0.0361 0.0333 0.0304 0.0271 0.0237 0.0200 0.0159 0.0116 0.0070 0.0033;
			];
			Fan = Fan(J_data, w_data, Ct_data, Cq_data);
		end
	end
end
