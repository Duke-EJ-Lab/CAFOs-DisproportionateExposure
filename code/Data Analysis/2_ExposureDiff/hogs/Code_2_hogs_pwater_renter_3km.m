%% Clear Matlab
clear all;
close all;
clc;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%% 3km %%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% Add Paths to Scripts and Data folders
addpath('...');

% read data
data = readtable('final_data.csv');
% drop houses in urban areas
data(data.UrbanArea_Indicator_3km == 1, :) = [];

% keep pwater houses
data(data.gwater == 1, :) = [];

% keep renters
data(data.owner == 1, :) = [];
%%
% CAFO exposure
hogs = data.agghogs3km_LargeCAFO;
poultry = data.aggpoultry3km_LargeCAFO;

% race variables
race_W = data.race_W;
race_B = data.race_B;
race_H = data.race_H;
n_white = sum(race_W == 1);
n_black = sum(race_B == 1);
n_his = sum(race_H == 1);
% other variables
n = size(data,1);
income = data.family_income/1000;
owner = data.owner;
% exposure and income by races
hogs_W = hogs(race_W==1);
hogs_B = hogs(race_B==1);
hogs_H = hogs(race_H==1);
income_W = income(race_W==1);
income_B = income(race_B==1);
income_H = income(race_H==1);

% generate matrix (drop observations in high income)
W_hogs = [income_W,hogs_W];
W_hogs(income_W > 220, :) = [];
B_hogs = [income_B,hogs_B];
B_hogs(income_B > 220, :) = [];
H_hogs = [income_H,hogs_H];
H_hogs(income_H > 220, :) = [];

% only keep the income bins in all 3 races 
%(need to calcuatle difference in exposure)
bin_W = unique(W_hogs(:,1));
bin_B = unique(B_hogs(:,1));
bin_H = unique(H_hogs(:,1));
bin1 = intersect(bin_W,bin_B,'row');
bin = intersect(bin1,bin_H,'row');

% average based on actual data
average_hogs_W = func_MA_CAFO(bin,W_hogs);
average_hogs_B = func_MA_CAFO(bin,B_hogs);
average_hogs_H = func_MA_CAFO(bin,H_hogs);

% calcualte exposure differences
hogs_BW = average_hogs_B - average_hogs_W;
hogs_HW = average_hogs_H - average_hogs_W;

%% bootstrap and CI
BW_bootstrap = zeros(size(bin,1),200);
HW_bootstrap = zeros(size(bin,1),200);

% White
for j = 1:200
    ind = randsample(1:size(W_hogs,1),...
        size(W_hogs,1),'true');
    hogs_sample = W_hogs(ind,:);
    average_W = func_MA_CAFO(bin,hogs_sample);

    ind = randsample(1:size(B_hogs,1),...
        size(B_hogs,1),'true');
    hogs_sample = B_hogs(ind,:);
    average_B = func_MA_CAFO(bin,hogs_sample);

    ind = randsample(1:size(H_hogs,1),...
        size(H_hogs,1),'true');
    hogs_sample = H_hogs(ind,:);
    average_H = func_MA_CAFO(bin,hogs_sample);

    BW_bootstrap(:,j) = average_B - average_W;
    HW_bootstrap(:,j) = average_H - average_W;   
end
% confidence interval
CI_HW = func_CI95(bin,HW_bootstrap);
CI_BW = func_CI95(bin,BW_bootstrap);

%% plots
% drop observations in high income
plots_BW = [bin,hogs_BW,CI_BW];
plots_BW(bin > 120,:)=[];
plots_HW = [bin,hogs_HW,CI_HW];
plots_HW(bin > 120,:)=[];

% save data
Pwater_Renter_3km_BW = plots_BW;
Pwater_Renter_3km_HW = plots_HW;
save('Pwater_Renter_3km_BW.mat',...
    'Pwater_Renter_3km_BW');
save('Pwater_Renter_3km_HW.mat',...
    'Pwater_Renter_3km_HW');

