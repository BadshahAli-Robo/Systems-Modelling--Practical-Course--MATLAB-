% % Rate-balance plots
% % 
% % 1) Linear system with no feedback, forward rate depends on [S]
% %
close all
clear

Astar = 0:0.001:1 ;
kplus = 2 ;
kminus = 5 ;

BR = kminus*Astar ;
figure
hold on 
plot(Astar,BR,'r','LineWidth',2)
set(gca,'TickDir','Out')
xlabel('[A*]/[A]')
ylabel('Rates')

%for i=1:length(S)
%  FR = kplus*S(i)*(1-Astar) ;
%  [minpos,index] = min(abs(FR - BR)) ;
%  A_SS(i) = Astar(index) ;
%  plot(Astar,FR,'b','LineWidth',2)
%end
%axis([0 1 0 max(FR)])

%figure
%plot(S,A_SS,'bo-','LineWidth',2)
%set(gca,'TickDir','Out')
%xlabel('Stimulus [S]')
%ylabel('Steady-state [A*]/[A]')