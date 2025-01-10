clc;clear;

d_hole=1.4;
d_zhen=2.5;
h0=d_zhen/2/tan(9*pi/180);
R_change=sqrt((d_hole/2)^2+(d_zhen/2)^2);
dis_change=R_change/tan(9*pi/180)-h0;     %临界半径时对应的针阀和喷孔的距离
A100_xishu=0.85*sqrt(2*(100-0.103)/0.85);   %P=100MPa时，计算流量Q时，面积A前的系数

%读取针阀运动曲线上对应的数据
data=xlsread('.\docs\针阀运动曲线.xlsx');
t_data=data(:,1);
t_data=t_data';
t_zhen=t_data(1:46);
t_zhen=[t_zhen,0.46:0.01:1.99];
t_zhen=[t_zhen,t_data(47:end)];

dis_data=data(:,2);
dis_data=dis_data';
dis_zhen=dis_data(1:46);
for i=0.46:0.01:1.99
    dis_zhen=[dis_zhen,2];
end
dis_zhen=[dis_zhen,dis_data(47:end)];

a_tan=tan(9*pi/180);
num=size(t_zhen);

x=t_zhen(end-34:end); 
y=dis_zhen(end-34:end);

%用蒙特卡洛法求V1
a1=1.742;b1=0.4318;c1=0.1533;
%dis_fit=a1*exp(-((t_fit-b1)/c1)^2);
%A=pi*((a_tan^2*dis_zhen(1:34)+7.8922).^2-d_zhen^2/4);
%A=pi*(a_tan^2*(a1*exp(-((t_fit-b1)/c1)^2)+7.8922).^2-d_zhen^2/4);
%Q=13.0319*pi*(a_tan^2*(a1*exp(-((t_fit-b1)/c1).^2)+7.8922)^2-d_zhen^2/4);

t_fit1=unifrnd(0,0.5,[1,10000000]);
Q_fit1=unifrnd(0,1.5,[1,10000000]);
pinshu1=sum(Q_fit1<=(a_tan^2*(a1*exp(-((t_fit1-b1)/c1).^2)+7.8922).^2-d_zhen^2/4)&t_fit1<=0.33);
area_V1=A100_xishu*pi*0.5*1.5*pinshu1/10^7;

%用蒙特卡洛法求V3
a2=1.739;b2=2.018;c2=0.1552;
t_fit2=unifrnd(2,2.5,[1,10000000]);
Q_fit2=unifrnd(0,2,[1,10000000]);
pinshu2=sum(Q_fit2<=(a_tan^2*(a2*exp(-((t_fit2-b2)/c2).^2)+7.8922).^2-d_zhen^2/4)&t_fit2>=2.12);
area_V3=A100_xishu*pi*0.5*2*pinshu2/10^7;

area_V2=A100_xishu*pi*0.7*0.7*(2.11-0.34);

%总的单位时间高压油输出的体积
area_out1=(area_V1+area_V3+area_V2)/100*2;
%V_in=area_out;          

%w=2*pi*V_in/88.5615;

eta=5.25/6.28;
area_V4=eta*A100_xishu*pi*0.7*0.7;
area_out=(area_V1+area_V3+area_V2)/100*2+area_V4;
V_in=area_out;  

w=2*pi*V_in/88.5615;
T_huanchong=2*pi/w;
t_huanchong=T_huanchong*eta;

