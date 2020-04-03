% does cltm of b9825,b9815,b9727,b972
% clearing orig. dat each time

diary deleteme.txt

fix(clock)
disp('loading and doing b9825')
load hhb9825
cltm(hhb9825,'b9825')
clear hhb9825

fix(clock)
disp('loading and doing b9815')
load hhb9815
cltm(hhb9815,'b9815')
clear hhb9815

fix(clock)
disp('loading and doing b9727')
load hhb9727
cltm(hhb9727,'b9727')
clear hhb9727

fix(clock)
disp('loading and doing b972')
load hhb972
cltm(hhb972,'b972')
clear hhb972
fix(clock)

diary off

