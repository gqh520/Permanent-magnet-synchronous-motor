function [Ualpha,Ubelta] =park_1_2r_2s(id,iq,theta)

 Ualpha=id*cos(theta)-iq*sin(theta);          % 2r/2q±ä»»
 Ubelta=id*sin(theta)+iq*cos(theta);
end