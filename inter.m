clc;clear;
syms t;
t_stop=2000;    %t_stop分别取2000、5000、10000
%求m1
m1=sqrt(2*(60-50/t_stop*t)*0.8709);
m_int1=int(m1,t,0,t_stop);             %  2s时总共流入的燃油的质量
square_m1=1.3084*double(m_int1);
%求m2
sum=0;
for k=1:t_stop/100
    sum=sum+44*exp(-0.169*exp(-0.00401*(100+100*(k-1)*50/t_stop))-0.04935);%100ms工作一次
end
square_m2=sum;
%求delta_m  （常数）
delta_m=(0.8677-0.85)*pi*0.25*5*5*500;        %  2s时流出的燃油的质量差（实际是高压油管进入了部分质量）
%求时间t_open
t_open1=10*(square_m2+delta_m)/(square_m1-square_m2-delta_m)

P_in=160;
P_battle=150;
rou_battle=0.8677;        %对应P_battle的rou_battle
Cd=0.85;
A_in=pi*0.25*1.4^2;
rou_in=exp(-0.169*exp(-0.00401*P_in)-0.04935);
Q_in=Cd*A_in*sqrt(2*(P_in-P_battle)/rou_in);
V_out=44/100;
V_int2=V_out;
V_int1=V_int2*rou_battle/rou_in;
t_open2=roots([V_int1-Q_in 10*V_int1])



