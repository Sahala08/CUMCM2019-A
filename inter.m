clc;clear;
syms t;
t_stop=2000;    %t_stop�ֱ�ȡ2000��5000��10000
%��m1
m1=sqrt(2*(60-50/t_stop*t)*0.8709);
m_int1=int(m1,t,0,t_stop);             %  2sʱ�ܹ������ȼ�͵�����
square_m1=1.3084*double(m_int1);
%��m2
sum=0;
for k=1:t_stop/100
    sum=sum+44*exp(-0.169*exp(-0.00401*(100+100*(k-1)*50/t_stop))-0.04935);%100ms����һ��
end
square_m2=sum;
%��delta_m  ��������
delta_m=(0.8677-0.85)*pi*0.25*5*5*500;        %  2sʱ������ȼ�͵������ʵ���Ǹ�ѹ�͹ܽ����˲���������
%��ʱ��t_open
t_open1=10*(square_m2+delta_m)/(square_m1-square_m2-delta_m)

P_in=160;
P_battle=150;
rou_battle=0.8677;        %��ӦP_battle��rou_battle
Cd=0.85;
A_in=pi*0.25*1.4^2;
rou_in=exp(-0.169*exp(-0.00401*P_in)-0.04935);
Q_in=Cd*A_in*sqrt(2*(P_in-P_battle)/rou_in);
V_out=44/100;
V_int2=V_out;
V_int1=V_int2*rou_battle/rou_in;
t_open2=roots([V_int1-Q_in 10*V_int1])



