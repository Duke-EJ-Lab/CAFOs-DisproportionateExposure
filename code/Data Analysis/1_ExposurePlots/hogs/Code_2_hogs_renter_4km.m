%% Clear Matlab
clear all;
close all;
clc;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%% 4km %%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% Add Paths to Scripts and Data folders
addpath('...');

% read data
data = readtable('final_data.csv');
% drop houses in urban areas
data(data.UrbanArea_Indicator_4km == 1, :) = [];

% keep renters
data(data.owner == 1, :) = [];
%%
n = size(data,1);
% CAFO exposure
hogs = data.agghogs4km_LargeCAFO;
poultry = data.aggpoultry4km_LargeCAFO;

% race variables
race_W = data.race_W;
race_B = data.race_B;
race_H = data.race_H;
n_white = sum(race_W == 1);
n_black = sum(race_B == 1);
n_his = sum(race_H == 1);
% other variables
income = data.family_income/1000;
renter = data.renter;

% CAFO variables for each race
hogs_W = hogs(race_W==1);
hogs_B = hogs(race_B==1);
hogs_H = hogs(race_H==1);
poultry_W = poultry(race_W==1);
poultry_B = poultry(race_B==1);
poultry_H = poultry(race_H==1);
% income variables by race
income_W = income(race_W==1);
income_B = income(race_B==1);
income_H = income(race_H==1);

% generate matrix
W_hogs = [income_W,hogs_W];
W_hogs(income_W > 220, :) = [];
B_hogs = [income_B,hogs_B];
B_hogs(income_B > 220, :) = [];
H_hogs = [income_H,hogs_H];
H_hogs(income_H > 220, :) = [];

% generat income bins for each race
bin_W = unique(W_hogs(:,1));
bin_B = unique(B_hogs(:,1));
bin_H = unique(H_hogs(:,1));

% average based on actual data
average_hogs_W = func_MA_CAFO(bin_W,W_hogs);
average_hogs_B = func_MA_CAFO(bin_B,B_hogs);
average_hogs_H = func_MA_CAFO(bin_H,H_hogs);

%% bootstrap and CI
% White
average_hogs_W_bootstrap = zeros(size(bin_W,1),200);
for j = 1:200
    hogs_sample_W = func_SampleDraw(bin_W,W_hogs);
    average_hogs_W_bootstrap(:,j) = func_MA_CAFO(bin_W,hogs_sample_W);
end
% 95% CI
CI_hogs_W = func_CI95(bin_W,average_hogs_W_bootstrap);

% Black
average_hogs_B_bootstrap = zeros(size(bin_B,1),200);
for j = 1:200
    hogs_sample_B = func_SampleDraw(bin_B,B_hogs);
    average_hogs_B_bootstrap(:,j) = func_MA_CAFO(bin_B,hogs_sample_B);
end
% 95% CI
CI_hogs_B = func_CI95(bin_B,average_hogs_B_bootstrap);

% Hispanic
average_hogs_H_Hootstrap = zeros(size(bin_H,1),200);
for j = 1:200
    hogs_sample_H = func_SampleDraw(bin_H,H_hogs);
    average_hogs_H_Hootstrap(:,j) = func_MA_CAFO(bin_H,hogs_sample_H);
end
% 95% CI
CI_hogs_H = func_CI95(bin_H,average_hogs_H_Hootstrap);


%% plots
% drop observations in really high income 
%(not enough minorities observations)
hogs_W = [bin_W,average_hogs_W,CI_hogs_W];
hogs_W(bin_W > 180,:)=[];
hogs_B = [bin_B,average_hogs_B,CI_hogs_B];
hogs_B(bin_B > 180,:)=[];
hogs_H = [bin_H,average_hogs_H,CI_hogs_H];
hogs_H(bin_H > 180,:)=[];

% plot exposure
figure(1)
hold all
% -------------- White -------------- %
F1 = plot(hogs_W(:,1),hogs_W(:,2),...
    'LineWidth',1.4,'color','k');
patch([hogs_W(:,1)' fliplr(hogs_W(:,1)')], ...
    [hogs_W(:,3)' fliplr(hogs_W(:,4)')], ...
    'k','FaceAlpha',0.3);
% -------------- Black -------------- %
F2 = plot(hogs_B(:,1),hogs_B(:,2),...
    'LineWidth',1.4,'color','b');
patch([hogs_B(:,1)' fliplr(hogs_B(:,1)')], ...
    [hogs_B(:,3)' fliplr(hogs_B(:,4)')], ...
    'b','FaceAlpha',0.3);
% -------------- Hispanic -------------- %
F3 = plot(hogs_H(:,1),hogs_H(:,2),...
    'LineWidth',1.4,'color','r');
patch([hogs_H(:,1)' fliplr(hogs_H(:,1)')], ...
    [hogs_H(:,3)' fliplr(hogs_H(:,4)')], ...
    'r','FaceAlpha',0.3);
hold off
legend([F1 F2 F3], ...
    'White','Black', 'Hispanic',...
    'Location','NE','Fontsize',10)
ylim([0,1.4])
ylabel('Hogs Exposure','FontSize',10)
xlabel('Income (in $1000)','FontSize',10)
title('Hogs Exposure, renter','FontSize',10)
% saveas(gcf,'Hogs_CI_renter_4km.png')


