function [Ua,Ub,Uc] = clark_1_2s_3s(Ualpha,Ubelta)

          % 2s/3s±ä»»  N3/N2 = 2/3   ÇÒ  ia + ib + ic = 0 
Ua = Ualpha;
Ub=-1/2*Ualpha+sqrt(3)/2*Ubelta; 
Uc=-1/2*Ualpha-sqrt(3)/2*Ubelta;
end
