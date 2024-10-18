close all
clear

Astar = 0:0.01:1;   % Range of A* (fractional state of activation)
S = 0:0.05:0.5;     % Range of Stimulus [S]
kplus = 2;          % Rate constant for forward reaction dependent on S
kf = 30;            % Rate constant for forward autocatalytic reaction
Atotal = 1;         % Total [A] in the system
kminus = 5;         % Rate constant for reverse reaction
Kmb = 0.1;          % Constant for backward reaction (saturating term)

% Calculate backward rate (BR) using the new equation
BR = kminus .* (Astar ./ (Astar + Kmb));

figure(1)
hold on
plot(Astar, BR, 'r', 'LineWidth', 2)  % Plot backward rate (BR)
set(gca, 'TickDir', 'Out')

figure(2)
hold on

% Loop through stimulus values [S]
for i = 1:length(S)
    % Calculate forward rate (FR) using the new equation
    FR = (kplus * S(i) + kf * Astar) .* (Atotal - Astar);
    
    figure(1)
    plot(Astar, FR, 'b', 'LineWidth', 2)  % Plot forward rate (FR)
    
    % Find the points where FR crosses BR (i.e., steady states)
    crossings = [];
    difference = FR - BR;
    
    % Check for sign changes in the difference between FR and BR
    for iii = 2:length(FR)
        if sign(difference(iii)) ~= sign(difference(iii-1))
            crossings = [crossings, iii];
        end
    end
    
    figure(2)
    plot(S(i), Astar(crossings), 'bo')  % Plot steady-state points
end

% Adjust the axis and labels for the first plot
figure(1)
axis([0 1 0 max(FR)])
set(gca, 'TickDir', 'Out')
xlabel('[A*]/[A_{total}]')  % Simplified label
ylabel('Rates')
legend('Backward Rate', 'Forward Rate')

% Adjust the axis and labels for the second plot
figure(2)
set(gca, 'TickDir', 'Out')
xlabel('Stimulus [S]')
ylabel('Steady-state [A*]/[A_{total}]')  % Simplified label