clc;clear;

P_in=160;
P_battle=100;
rou_battle=0.85;   
Cd=0.85;
A_in=pi*0.25*1.4^2;
rou_in=exp(-0.169*exp(-0.00401*P_in)-0.04935);
Q_in=Cd*A_in*sqrt(2*(P_in-P_battle)/rou_in);
V_out=44/100;
V_int2=V_out;
V_int1=V_int2*rou_battle/rou_in;
t_open=roots([V_int1-Q_in 10*V_int1])

