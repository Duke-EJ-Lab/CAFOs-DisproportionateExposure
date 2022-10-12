%% Clear Matlab
clear all;
close all;
clc;

x_race = categorical({'(H=0, P=0)','(H=0, P=1)',...
    '(H=1, P=0)', '(H=1, P=1)'});
x_race = reordercats(x_race,{'(H=0, P=0)','(H=0, P=1)',...
    '(H=1, P=0)', '(H=1, P=1)'});






%% race by water
%%%%%%%%%%%%%%%%%%%%%%%%% Low Income %%%%%%%%%%%%%%%%%%%%%%%%%

White_Low_00 = 0.61;
White_Low_01 = 0.11;
White_Low_10 = 0.09;
White_Low_11 = 0.19;

Black_Low_00 = 0.57;
Black_Low_01 = 0.13;
Black_Low_10 = 0.08;
Black_Low_11 = 0.22;

His_Low_00 = 0.51;
His_Low_01 = 0.12;
His_Low_10 = 0.11;
His_Low_11 = 0.27;

%%%%%%%%%%%%%%%%%%%%%%%%% Med Income %%%%%%%%%%%%%%%%%%%%%%%%%

White_Med_00 = 0.61;
White_Med_01 = 0.11;
White_Med_10 = 0.09;
White_Med_11 = 0.19;

Black_Med_00 = 0.54;
Black_Med_01 = 0.13;
Black_Med_10 = 0.09;
Black_Med_11 = 0.24;

His_Med_00 = 0.50;
His_Med_01 = 0.13;
His_Med_10 = 0.10;
His_Med_11 = 0.27;


%%%%%%%%%%%%%%%%%%%%%%%%% High Income %%%%%%%%%%%%%%%%%%%%%%%%%

White_High_00 = 0.63;
White_High_01 = 0.12;
White_High_10 = 0.07;
White_High_11 = 0.17;

Black_High_00 = 0.58;
Black_High_01 = 0.12;
Black_High_10 = 0.09;
Black_High_11 = 0.21;

His_High_00 = 0.56;
His_High_01 = 0.14;
His_High_10 = 0.08;
His_High_11 = 0.22;

% table creation
y_raceincome_low = ...
    [White_Low_00 Black_Low_00 His_Low_00;...
    White_Low_01 Black_Low_01 His_Low_01;...
    White_Low_10 Black_Low_10 His_Low_10;...
   White_Low_11 Black_Low_11 His_Low_11];
       
y_raceincome_med = ...
    [White_Med_00 Black_Med_00 His_Med_00;...
    White_Med_01 Black_Med_01 His_Med_01;...
    White_Med_10 Black_Med_10 His_Med_10;...
   White_Med_11 Black_Med_11 His_Med_11];

y_raceincome_high = ...
    [White_High_00 Black_High_00 His_High_00;...
    White_High_01 Black_High_01 His_High_01;...
    White_High_10 Black_High_10 His_High_10;...
   White_High_11 Black_High_11 His_High_11];





%% hogs exposure graph
figure(1)
subplot(3,1,1);
F1 = bar(x_race,y_raceincome_low);
F1(1).FaceColor = [0 0 0];
F1(2).FaceColor = [0 0 1];
F1(3).FaceColor = [1 0 0];
ylim([0,0.8])
ylabel('Probability','FontSize',8)
xtips1 = F1(1).XEndPoints;
ytips1 = F1(1).YEndPoints;
labels1 = string(F1(1).YData);
text(xtips1,ytips1,labels1,'HorizontalAlignment','center',...
    'VerticalAlignment','bottom','Fontsize',8)
xtips2 = F1(2).XEndPoints;
ytips2 = F1(2).YEndPoints;
labels2 = string(F1(2).YData);
text(xtips2,ytips2,labels2,'HorizontalAlignment','center',...
    'VerticalAlignment','bottom','Fontsize',8)
xtips3 = F1(3).XEndPoints;
ytips3 = F1(3).YEndPoints;
labels3 = string(F1(3).YData);
text(xtips3,ytips3,labels3,'HorizontalAlignment','center',...
    'VerticalAlignment','bottom','Fontsize',8)
%legend(F1, {'White','Black' 'Hispanic'},'location','NW','FontSize',8)
title('Low Income','FontSize',10)

subplot(3,1,2);
F2 = bar(x_race,y_raceincome_med);
F2(1).FaceColor = [0 0 0];
F2(2).FaceColor = [0 0 1];
F2(3).FaceColor = [1 0 0];
ylim([0,0.8])
ylabel('Probability','FontSize',8)
xtips1 = F2(1).XEndPoints;
ytips1 = F2(1).YEndPoints;
labels1 = string(F2(1).YData);
text(xtips1,ytips1,labels1,'HorizontalAlignment','center',...
    'VerticalAlignment','bottom','Fontsize',8)
xtips2 = F2(2).XEndPoints;
ytips2 = F2(2).YEndPoints;
labels2 = string(F2(2).YData);
text(xtips2,ytips2,labels2,'HorizontalAlignment','center',...
    'VerticalAlignment','bottom','Fontsize',8)
xtips3 = F2(3).XEndPoints;
ytips3 = F2(3).YEndPoints;
labels3 = string(F2(3).YData);
text(xtips3,ytips3,labels3,'HorizontalAlignment','center',...
    'VerticalAlignment','bottom','Fontsize',8)
%legend(F2, {'White','Black' 'Hispanic'},'location','NW','FontSize',8)
title('Medium Income','FontSize',10)

subplot(3,1,3);
F3 = bar(x_race,y_raceincome_high);
F3(1).FaceColor = [0 0 0];
F3(2).FaceColor = [0 0 1];
F3(3).FaceColor = [1 0 0];
ylim([0,0.8])
ylabel('Probability','FontSize',8)
xtips1 = F3(1).XEndPoints;
ytips1 = F3(1).YEndPoints;
labels1 = string(F3(1).YData);
text(xtips1,ytips1,labels1,'HorizontalAlignment','center',...
    'VerticalAlignment','bottom','Fontsize',8)
xtips2 = F3(2).XEndPoints;
ytips2 = F3(2).YEndPoints;
labels2 = string(F3(2).YData);
text(xtips2,ytips2,labels2,'HorizontalAlignment','center',...
    'VerticalAlignment','bottom','Fontsize',8)
xtips3 = F3(3).XEndPoints;
ytips3 = F3(3).YEndPoints;
labels3 = string(F3(3).YData);
text(xtips3,ytips3,labels3,'HorizontalAlignment','center',...
    'VerticalAlignment','bottom','Fontsize',8)
legend(F3, {'White',...
    'Black' 'His'},'location','NE','FontSize',8)
title('High Income','FontSize',10)
% saveas(gcf,'Bivariate_5km.png')


