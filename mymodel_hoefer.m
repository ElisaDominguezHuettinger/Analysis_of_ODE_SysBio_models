function yss = mymodel_hoefer(x)%, otherstuffifneeded)

nominal_parameters =[.02, 5,1, 1];
nominal_parameters(1:4)=x(1:4);


%the parameters:
alpha= x(1);
k_g=x(2);
k=x(3);
IL4=x(4);

dGata3dt=@(t,Gata3, IL4, alpha, k_g, k)alpha.*IL4+k_g.*Gata3.^2./(( 1+Gata3).^2)-k.*Gata3;

tspan = [0 35];
% Initial conditions of states
Gata30 =x(5);
[t,y] = ode45(@(t,y)dGata3dt(t,y, IL4, alpha, k_g, k),tspan,Gata30);


yss=y(end);
