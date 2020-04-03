% These examples illustrate the use of the chirplet transform on both ``toy''
% and actual practical problems.
%
% Working these simple examples and examining the associated script files will
% give you some idea how to compute some of the various 2-d slices through the
% chirplet transform.  They are meant to be simple and illustrative rather
% than complicated and elegant, so you will no doubt want to modify and
% experiment further with your specific problem(s).

% create some synthetic data (a chirp):
c=chirp(0,.25,512);    % chirp beginning at f=0 and ending at f=.25; 512 pts

% plot this chirp:
subplot(211);plot(real(c));grid;subplot(212);plot(imag(c));grid
% (you probably want to mouse these long lines and drop into a Matlab window)
% (instruction lines are commented so you can just mouse comments as well)

% now compute the Frequency-Frequency plane of the chirplet transform of c:
% if vers>=4.0; figure; else; subplot(111); end;
figure;

Cff=ff(c,.5,39);       % computes and plots contours: notice there is indeed
                       % a strong peak at coordinates (0,.25).  Note that
                       % coordinates (0,0) are in the center and that the
                       % axes are in sample (pixel) coordinates of Cff
% Try generating a number of chirps with various Fbeg and Fend, add (avg) them
% together, compute the FF plane of the result; you will see a peak for each.

% load some actual radar data (from my low budget uncalibrated home-made radar)
% load vballdrop  chrome       % load radar return from a falling volleyball
v = readtable('zhao_before.csv')
v = table2array(v)

disp('Is v numerical?');
disp(class(v));

v=v-mean(v);           % subtract mean
Vtf=tf(v);             % compute tf plane of chirplet transform (which is
disp('Is vtf numerical?')
disp(class(Vtf))     % just the STFT).
% disp(Vtf)
% imagesc(-abs(Vtf))     % view as a density plot (black=highest values)
% fplot(Vtf, [0 5])       % observe the linear portion while the ball was in
% subplot(2,1,1)
% step(Vtf)
% subplot(2,1,2)
% impulse(Vtf)              % free fall; then the ball hits the radar and bounces
                       % around a little.
vp=v(6670:6670+4999);  % take part of the data (about 5000 samples from when
                       % the ball was in free fall).
Vff=ff(vp,.5,39)       % takes a long time (see Bug notice in help)
                       % so try looking at part of the data or decimating the
                       % data by a factor of 2:
Vff=ff(decimate(vp(1:1000),2),.5,39)
                       % You see the mirroring about f=0 because the signal is
                       % real.  Nothing was moving away from the radar, so
                       % you can get a signal like a more expensive (complex)
                       % radar w/ I(inphase) and Q(uadrature) would have given.
vp=hilbert(vp);        % Project to the Hardy space (get rid of neg. freq.)
                       % using the Hilbert transform.
Vff=ff(decimate(vp(1:1000),2),.5,39);  % 39 by 39 pixel image
                       % now you see the true picture: a large peak about 3
                       % pixels directly above the origin (0,0).  This is at
                       % coordinates (Vbeg,Vend)=(0,3/39) indicating an object
                       % started out at 0 velocity toward the radar, and ended
                       % up going k3/39 toward the radar.
mesh(abs(Vff))         % and observe that the peaks are quite sharp
% now that you see where the area of interest is, zoom in and take a close look
Vff=ff(decimate(vp(1:1000),2),.2,39);
% if vers>=4.0; imagesc(abs(Vff)); axis('image'); grid; end
imagesc(abs(Vff)); axis('image'); grid;

%if
% now try looking at other parts of the data.  Try samples 1001:2000.
% if you draw a line from the lower left to upper right, you will notice that
% the peak is the same distance from this line as before.  The distance from
% the f=0 line is called the ``chirpiness'', and corresponds to acceleration
% (which is constant by virtue of the const. mass and const. accel. due to g)

% load hhb9825 % Doppler return from a small floating iceberg fragment
% Btf=tf(b);             % tf slice of chirplet is the STFT
% imagesc(-abs(Btf));    % notice the wavy pattern (acceleration).
                       % STFT assumes short-time stationarity (assumes velocity
                       % constant over short interval), but ff plane assuems
                       % acceleration constant over short interval.  Both
                       % may be wrong but latter is a weaker assumption.
                       % Chirplet approximates the wavy curve as piecewise
                       % linear as opposed to the STFT which approximates it
                       % as piecewise constant (staircased)
% try some ff planes for various parts of this data.  Note that the ff plane
% allows you to integrate over longer datasets than just using the power
% spectrum.

% The scale-frequency plane has been quite useful in characterizing Doppler
% returns from marine radar.
% Try running sf.m (it assumes the data you want to analyze is in variable b:
% sf                     % This is an interactive script, not a function.
                       % Just hit return at each prompt to get defaults.
                       % An important property of sea clutter is that the
                       % spectrum of its radar backscatter happens to differ 
                       % widely at differing scales, while targets tend to
                       % have similar spectral characteristics across widely
                       % varying scales.  The target is quite evident in this
                       % data sample.

% Try modifying these sample .m files to produce some other slices through
% the chirplet transform.  Try, for example, copying the file ff.m to another
% file like ts.m, and changing it to go through the time-scale plane.
% If you happened to use a ``window'' that had no DC component, you have
% just performed a Continuous Wavelet Transform.  Try a tc (Time-Chirpiness)
% and Frequency-Chirpiness plane.  Later you might want to modify the scripts
% to use the FFT for more efficient computation of these slices, but for now,
% perhaps just see which of the slices captures the essence of your particular
% application.  It may well turn out that the tf or ts plane gives you the
% best performance, in which case the chirplet transform may do no better than
% the Fourier or wavelet.  If you do find anything interesting out in chirplet
% space, out where no one has been before (e.g. off of the usual tf and ts
% planes) please let me know what you find.

% Steve Mann
% steve@media.mit.edu
% MIT E15-389
% 20 Ames Street
% Cambridge, MA02139

% Developed by Steve Mann, currently with the Media Laboratory, MIT,
% Cambridge, Massachusetts, 02139.
% 
% Permission to use, copy, or modify this software and its documentation
% for educational and research purposes only and without fee is hereby
% granted, provided that this copyright notice and the original authors'
% names appear on all copies and supporting documentation.  If individual
% files are separated from this distribution directory structure, this
% copyright notice must be included.  For any other uses of this software,
% in original or modified form, including but not limited to distribution
% in whole or in part, specific prior permission must be obtained from
% MIT.  These programs shall not be used, rewritten, or adapted as the
% basis of a commercial software or hardware product without first
% obtaining appropriate licenses from MIT.  MIT. makes no representations
% about the suitability of this software for any purpose.  It is provided
% "as is" without express or implied warranty.

