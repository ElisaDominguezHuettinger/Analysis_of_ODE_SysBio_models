function yss = mymodel_FA(x)

nominal_parameters =[1, 1, 1, 1, 1, 1];
nominal_parameters(1:6)=x(1:6);


%the parameters:

De =1;
Pa =1;
km =1;
n =1;


tspan = [0 35];
% Initial conditions of states
Tr0 = x(7);
VAI0 = x(8);
Fe0 = x(9);

y0=[ Tr0 VAI0 Fe0];

 [t,y] = ode45(@(t,y)FA_ODEs(t,y,x, De, Pa, km, n),tspan,y0);


 yss=y(end);
end


function dydt = FA_ODEs(~,y,x, De, Pa, km, n)
k1 = x(1);
k2 =x(2);
k3 =x(3);
k4 =x(4);
k5 =x(5);
k6 =x(6);

 dydt = zeros(3,1);
 
Tr=y(1);
VAI=y(2);
Fe=y(3);
 

Ac=0;
  FA= @(VAI)VAI^2/(km+VAI^2);
  
  dydt(1)=k1.*FA(VAI).*De.*Pa.*(1/(1+Fe^n))- k2.*Tr.*(1+Ac);
  dydt(2)=k3.*(1+FA(VAI))-k4.*VAI;
  dydt(3)=k5-k6.*Fe.*VAI;
  
end
