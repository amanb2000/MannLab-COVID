diary deleteme
dat = bird(32,16,512).'; % synthetic chirp

fix(clock)
a_lim = 512/8
b_lim = 512/8
similarity=clt_ab(dat,a_lim,b_lim,99);
save clt_ab_synth similarity a_lim b_lim

clear
fix(clock)
diary off
exit

