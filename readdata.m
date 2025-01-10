clc;clear;
data=xlsread('.\docs\弹性模量y与压力x的关系.xlsx');
p=data(:,1);    %读取p
E=data(:,2);    %读取p对应的E数值