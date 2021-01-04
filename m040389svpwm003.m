function [sys,x0,str,ts] = m040389svpwm003(t,x,u,flag)
tsam=0.02/20;
switch flag,
      case 0,
    [sys,x0,str,ts]=Initialization(tsam);
      case {1,2,4,9},
    sys=[];
      case 3,
    sys=mdlOutputs(t,x,u);
      otherwise
    DAStudio.error('Simulink:blocks:unhandledFlag', num2str(flag));

end
function [sys,x0,str,ts]=Initialization(tsam)
sizes = simsizes;

sizes.NumContStates  = 0;
sizes.NumDiscStates  = 0;
sizes.NumOutputs     = 2;
sizes.NumInputs      = 2;
sizes.DirFeedthrough = 1;
sizes.NumSampleTimes = 1;   %1个采样时间
sys = simsizes(sizes);
x0  = [];
str = [];
ts  = [tsam 0];

function sys=mdlOutputs(t,x,u)
sys=[u(1),u(2)];
    
