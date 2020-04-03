%%%load CLTM_b9825
%%%cltmf(CLTM,'b9825','target:  b98, range 25')

%%%load CLTM_b9815
%%%%cltmf(CLTM,'b9815','clutter:  b98, range 15')

!gpp -dps CLTM_b9825
!gpp -dps CLTM_b9815

!lpr -Pps CLTM_b9825.ps
!lpr -Pps CLTM_b9815.ps

