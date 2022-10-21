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

% keep gwater houses
data(data.gwater == 0, :) = [];

% keep renters
data(data.owner == 1, :) = [];
%%
% CAFO exposure
poultry = data.aggpoultry4km_LargeCAFO;

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
poultry_W = poultry(race_W==1);
poultry_B = poultry(race_B==1);
poultry_H = poultry(race_H==1);
income_W = income(race_W==1);
income_B = income(race_B==1);
income_H = income(race_H==1);

% generate matrix
W_poultry = [income_W,poultry_W];
B_poultry = [income_B,poultry_B];
H_poultry = [income_H,poultry_H];

% only keep bins that show in all 3 races
bin_W = unique(W_poultry(:,1));
bin_B = unique(B_poultry(:,1));
bin_H = unique(H_poultry(:,1));
bin1 = intersect(bin_W,bin_B,'row');
bin = intersect(bin1,bin_H,'row');

% average based on actual data
average_poultry_W = func_MA_CAFO(bin,W_poultry);
average_poultry_B = func_MA_CAFO(bin,B_poultry);
average_poultry_H = func_MA_CAFO(bin,H_poultry);
% calculate exposure difference
poultry_BW = average_poultry_B - average_poultry_W;
poultry_HW = average_poultry_H - average_poultry_W;

%% bootstrap and CI
BW_bootstrap = zeros(size(bin,1),200);
HW_bootstrap = zeros(size(bin,1),200);

% White
for j = 1:200
    ind = randsample(1:size(W_poultry,1),...
        size(W_poultry,1),'true');
    poultry_sample = W_poultry(ind,:);
    average_W = func_MA_CAFO(bin,poultry_sample);

    ind = randsample(1:size(B_poultry,1),...
        size(B_poultry,1),'true');
    poultry_sample = B_poultry(ind,:);
    average_B = func_MA_CAFO(bin,poultry_sample);

    ind = randsample(1:size(H_poultry,1),...
        size(H_poultry,1),'true');
    poultry_sample = H_poultry(ind,:);
    average_H = func_MA_CAFO(bin,poultry_sample);

    BW_bootstrap(:,j) = average_B - average_W;
    HW_bootstrap(:,j) = average_H - average_W;   
end
% confidence interval
CI_HW = func_CI95(bin,HW_bootstrap);
CI_BW = func_CI95(bin,BW_bootstrap);

%% plots
% drop high income households (not enough obs)
plots_BW = [bin,poultry_BW,CI_BW];
plots_BW(bin > 120,:)=[];
plots_HW = [bin,poultry_HW,CI_HW];
plots_HW(bin > 120,:)=[];

% save data
Gwater_Renter_4km_BW = plots_BW;
Gwater_Renter_4km_HW = plots_HW;
save('Gwater_Renter_4km_BW.mat',...
    'Gwater_Renter_4km_BW');
save('Gwater_Renter_4km_HW.mat',...
    'Gwater_Renter_4km_HW');
