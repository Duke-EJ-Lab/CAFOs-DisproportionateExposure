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

% keep gwater houses
data(data.gwater == 0, :) = [];

% keep owners
data(data.owner == 0, :) = [];
%%
% welfare loss
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

poultry_W = poultry(race_W==1);
poultry_B = poultry(race_B==1);
poultry_H = poultry(race_H==1);

income_W = income(race_W==1);
income_B = income(race_B==1);
income_H = income(race_H==1);

%
W_poultry = [income_W,poultry_W];
B_poultry = [income_B,poultry_B];
H_poultry = [income_H,poultry_H];

% bin_W = unique(income_W);
bin_W = unique(W_poultry(:,1));
bin_B = unique(B_poultry(:,1));
bin_H = unique(H_poultry(:,1));
bin1 = intersect(bin_W,bin_B,'row');
bin = intersect(bin1,bin_H,'row');


% average based on actual data
average_poultry_W = func_MA_CAFO(bin,W_poultry);
average_poultry_B = func_MA_CAFO(bin,B_poultry);
average_poultry_H = func_MA_CAFO(bin,H_poultry);


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

CI_HW = func_CI95(bin,HW_bootstrap);
CI_BW = func_CI95(bin,BW_bootstrap);



%% plots
% https://www.mathworks.com/matlabcentral/answers/443322-fill-the-region-between-two-lines
plots_BW = [bin,poultry_BW,CI_BW];
plots_BW(bin > 180,:)=[];

plots_HW = [bin,poultry_HW,CI_HW];
plots_HW(bin > 180,:)=[];

Gwater_Owner_3km_BW = plots_BW;
Gwater_Owner_3km_HW = plots_HW;

save('Gwater_Owner_3km_BW.mat',...
    'Gwater_Owner_3km_BW');
save('Gwater_Owner_3km_HW.mat',...
    'Gwater_Owner_3km_HW');

