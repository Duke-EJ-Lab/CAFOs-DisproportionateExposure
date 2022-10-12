%% Clear Matlab
clear all;
close all;
clc;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%% 5km %%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% Add Paths to Scripts and Data folders
addpath('...');

load('Gwater_Renter_5km_BW.mat');
load('Gwater_Renter_5km_HW.mat');
load('Pwater_Renter_5km_BW.mat');
load('Pwater_Renter_5km_HW.mat');


%%
% -------------- Black - White -------------- %
figure(1)
hold all
% -------------- Gwater -------------- %
F1 = plot(Gwater_Renter_5km_BW(:,1),...
    Gwater_Renter_5km_BW(:,2),...
    'LineWidth',1.4,'color','b');
patch([Gwater_Renter_5km_BW(:,1)' ...
    fliplr(Gwater_Renter_5km_BW(:,1)')], ...
    [Gwater_Renter_5km_BW(:,3)' ...
    fliplr(Gwater_Renter_5km_BW(:,4)')], ...
    'b','FaceAlpha',0.6);
% -------------- Pwater -------------- %
F2 = plot(Pwater_Renter_5km_BW(:,1),...
    Pwater_Renter_5km_BW(:,2),'--',...
    'LineWidth',1.4,'color','b');
patch([Pwater_Renter_5km_BW(:,1)' ...
    fliplr(Pwater_Renter_5km_BW(:,1)')], ...
    [Pwater_Renter_5km_BW(:,3)' ...
    fliplr(Pwater_Renter_5km_BW(:,4)')], ...
    'b','FaceAlpha',0.3);
hold off
ylim([-0.5,2.5])
legend([F1 F2], ...
    'Gwater','Pwater','Location','NE','Fontsize',10)
ylabel('Black - White','FontSize',10)
xlabel('Income (in $1000)','FontSize',10)
title('Black vs. White, Renter',...
    'FontSize',10)
% saveas(gcf,'HogsDiff_Water_BW_renter_5km.png')

%%
% -------------- His - White -------------- %
figure(2)
hold all
% -------------- Gwater -------------- %
F1 = plot(Gwater_Renter_5km_HW(:,1),...
    Gwater_Renter_5km_HW(:,2),...
    'LineWidth',1.4,'color','r');
patch([Gwater_Renter_5km_HW(:,1)' ...
    fliplr(Gwater_Renter_5km_HW(:,1)')], ...
    [Gwater_Renter_5km_HW(:,3)' ...
    fliplr(Gwater_Renter_5km_HW(:,4)')], ...
    'r','FaceAlpha',0.6);
% -------------- Pwater -------------- %
F2 = plot(Pwater_Renter_5km_HW(:,1),...
    Pwater_Renter_5km_HW(:,2),'--',...
    'LineWidth',1.4,'color','r');
patch([Pwater_Renter_5km_HW(:,1)' ...
    fliplr(Pwater_Renter_5km_HW(:,1)')], ...
    [Pwater_Renter_5km_HW(:,3)' ...
    fliplr(Pwater_Renter_5km_HW(:,4)')], ...
    'r','FaceAlpha',0.2);
hold off
ylim([-0.5,2.5])
legend([F1 F2], ...
    'Gwater','Pwater','Location','NE','Fontsize',10)
ylabel('His - White','FontSize',10)
xlabel('Income (in $1000)','FontSize',10)
title('His vs. White, Renter',...
    'FontSize',10)
% saveas(gcf,'HogsDiff_Water_HW_renter_5km.png')

