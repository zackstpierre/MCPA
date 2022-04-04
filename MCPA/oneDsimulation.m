function [] = oneDsimulation(time, timestep, force) 


set(0,'DefaultFigureWindowStyle','docked')
set(0,'defaultaxesfontsize',20)
set(0,'defaultaxesfontname','Times New Roman')
set(0,'DefaultLineLineWidth', 2);


%Initialize

x_old = 0;
v_old= 0;

T = time;
nT = timestep;
Ex = force;

charge = 1.60217653e-19; %electron charge
m_e = 9.10938215e-31;   % electron mass

velocities = [];
positions = [];


timecounter = [];
lasttime = 0;
counter = 1;



for i = 1:nT:T

    v = v_old + ((charge * Ex)/m_e) * nT;
    x = x_old + (v * nT);

    if rand() < 0.05
        v=0;
    end

    velocities(counter) = v;
    positions(counter) = x;

    timecounter(counter) = lasttime + nT;
    
    subplot(2,1,1)
    plot(timecounter,velocities)
%     hold on
    subplot(2,1,2);
    plot(timecounter, positions);
%     hold on

    x_old = x;
    v_old = v;
    lasttime = timecounter(counter);
    counter = counter + 1;

    pause(.001)

end

subplot(2,1,1)
hold off
subplot(2,1,2)
hold off

