%ELEC4700 Assignment 3
%Zachary St. Pierre
%101094217



%-------------------------------------------------------------------------%
clc;
clear;
close all;




%-------------------------------------------------------------------------%
%Variables%

Q = 0.1; %Volts

N_e = 100;  %number of electrons
N_plot = randi(N_e, 2, 1);  %number of electrons to plot

m_0 = 9.1093837015e-31;
m_n = 0.26 * m_0;      % mass of electrons

q = 1.602e-19;

Eps = 8.854e-12;

c_bolt = 1.381e-23;
Temp = 300; 
t_mn = 0.2e-12;

size_x = 200e-9; %length of region
size_y = 100e-9; %width of region

nT = 5e-15;
T = 100*nT;

%probability of scatter

Pscat = 1 - exp(-nT/t_mn);
%Pscat = 0.5;
Pscatter = [];

%velocity

Vth = sqrt(2.*c_bolt.*Temp./m_n);

Vx = [];
Vy = [];

% position
Px = [];
Py = []; 

Pscat = 1 - exp(-nT/t_mn);
Pscatter = [];

%Maxwell-Boltzman deviation calculations
deviation = sqrt((c_bolt*Temp)/m_n);
rand_speed = deviation;

%Acceleration calc
E_field = Q/size_x;
E_force = q*E_field;
A = E_force/m_n;


%-------------------------------------------------------------------------%

%Create random points%
Px = rand(N_e,1)*size_x;
Py = rand(N_e,1)*size_y;

Vx = randn(N_e,1) * rand_speed;
Vy = randn(N_e,1) * rand_speed;


figure(1)
hold on
axis([0 size_x 0 size_y]);

for i=1:1000

   Pscatter = rand(N_e,1);

   Px_old = Px;
   Py_old = Py;
   
   P_scatter_locations = Pscatter < Pscat;
   Vy(P_scatter_locations) = randn(1) * Vth;
   Vx(P_scatter_locations) = randn(1) * Vth; 

   Vx_old = Vx;

   Px = Px_old + (Vx * nT);
   Py = Py_old + (Vy * nT);

   Vx = Vx_old + (A * nT);

   Px_outside_right = Px > size_x;
   Px_outside_left  = Px < 0;

   Py_top = Py > size_y;
   Py_bottom = Py < 0;

   Px(Px_outside_right) = Px(Px_outside_right) - size_x;
   Px(Px_outside_left) = Px(Px_outside_left) + size_x;

   Px_old(Px_outside_right) = Px_old(Px_outside_right) - size_x;
   Px_old(Px_outside_left) = Px_old(Px_outside_left) + size_x;

   Vy(Py_top) = Vy(Py_top)* -1;
   Vy(Py_bottom) = Vy(Py_bottom) * -1;
   
    for j = 1: length(N_plot)
        plot([Px_old(N_plot(j)) Px(N_plot(j))]',[Py_old(N_plot(j)) Py(N_plot(j))]','SeriesIndex',j)
        hold on
    end 

   %store average velocity for current density calc 
   avgVel(i) = mean(mean(sqrt(Vx.^2 + Vy.^2)));

   %store times for plotting against current
   times(i) = i * nT;

   pause(0.01)
end


%drift current

J = q .* N_e .* avgVel;

figure()
plot(times,J)

%temp
temp_plane = avgVel.^2.*m_n/(2.*c_bolt);

figure()
plot(times,temp_plane)