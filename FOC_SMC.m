function [sys,x0,str,ts] = FOC_SMC(t,x,u,flag)
switch flag
  case 0
    [sys,x0,str,ts]=mdlInitializeSizes;
  case 1
    sys=mdlDerivatives(t,x,u);
  case {2,4,9}
    sys=[];
  case 3
    sys=mdlOutputs(t,x,u);
  otherwise
    DAStudio.error('Simulink:blocks:unhandledFlag', num2str(flag));
end

function [sys,x0,str,ts]=mdlInitializeSizes   %系统的初始化
sizes = simsizes;
sizes.NumContStates  = 0;   %设置系统连续状态的变量
sizes.NumDiscStates  = 0;   %设置系统离散状态的变量
sizes.NumOutputs     = 1;   %设置系统输出的变量
sizes.NumInputs      = 4;   %设置系统输入的变量
sizes.DirFeedthrough = 1;   %如果在输出方程中显含输入变量u，则应该将本参数设置为1
sizes.NumSampleTimes = 0;   % 模块采样周期的个数
                            % 需要的样本时间，一般为1.
                            % 猜测为如果为n，则下一时刻的状态需要知道前n个状态的系统状态
sys = simsizes(sizes);
x0  = [];                   % 系统初始状态变量
str = [];                   % 保留变量，保持为空
ts  = [];                   % 采样时间[t1 t2] t1为采样周期，如果取t1=-1则将继承输入信号的采样周期；参数t2为偏移量，一般取为0
 
    
function sys=mdlOutputs(t,x,u)   %产生（传递）系统输出
%给定转速
we = u(1); 
%电角速度
w = u(2);  
%  we-w的积分
inte_w = u(3);
%  负载转矩
TL = u(4);

%自定义系数
xite = 2;   %为控制系统趋近滑模面s=0的趋近速度
q = 3;      %收敛速度直接由常数 q 决定
c = 10;     %条件 c>0

q1 = we - w;   %x1
q2 = inte_w;   %x2
%滑模面
s = q1 + c * q2;
% s = c * q1 + q2;
%极对数
p = 4;
%永磁磁链
faif = 0.0714394;
%转动惯量
J = 0.000621417;
D = 3*p*faif/(2*J);
%阻尼系数
B = 0.000303448;
ut  = 1/D*(c * q1 + B/J*w + 1/J*TL + xite*sign(s) + q*s);

sys(1) = ut;

