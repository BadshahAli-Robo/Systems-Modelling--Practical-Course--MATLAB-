% Define constants
global k1 kp Km Vin
Vin = 0.36;
k1 = 0.02;
kp = 6;
Km = 13;

% Simulation time 
tspan = [0,1000];

% Initial conditions
ATP = 1;
G = 0;
y0 = [ATP,G];

% Run simulation
[t,y] = ode89(@dydt_osc,tspan,y0) ;

% Plot results
figure(1)
plot(t,y);

%ATP=y(:,1);

function dydt = dydt_osc(t,y)
    global k1 kp Km Vin

    ATP = y(1);
    G = y(2);

    dATP = 2*k1*G*ATP - kp*ATP/(ATP+Km) ;
    dG = Vin - k1*G*ATP;

    dydt = [dATP; dG];
end
