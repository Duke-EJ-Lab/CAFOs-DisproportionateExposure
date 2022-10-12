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

% average based on actual data
average_poultry_W = func_MA_CAFO(bin_W,W_poultry);
average_poultry_B = func_MA_CAFO(bin_B,B_poultry);
average_poultry_H = func_MA_CAFO(bin_H,H_poultry);

%% bootstrap and CI

% White
average_poultry_W_bootstrap = ...
    zeros(size(bin_W,1),200);
for j = 1:200
    poultry_sample_W = ...
        func_SampleDraw(bin_W,W_poultry);
    average_poultry_W_bootstrap(:,j) = ...
        func_MA_CAFO(bin_W,poultry_sample_W);
end
% 95% CI
CI_poultry_W = func_CI95(bin_W,...
    average_poultry_W_bootstrap);



% Black
average_poultry_B_bootstrap = ...
    zeros(size(bin_B,1),200);
for j = 1:200
    poultry_sample_B = ...
        func_SampleDraw(bin_B,B_poultry);
    average_poultry_B_bootstrap(:,j) = ...
        func_MA_CAFO(bin_B,poultry_sample_B);
end
% 95% CI
CI_poultry_B = func_CI95(bin_B,...
    average_poultry_B_bootstrap);


% Hispanic
average_poultry_H_Hootstrap = zeros(size(bin_H,1),200);
for j = 1:200
    poultry_sample_H = ...
        func_SampleDraw(bin_H,H_poultry);
    average_poultry_H_Hootstrap(:,j) = ...
        func_MA_CAFO(bin_H,poultry_sample_H);
end
% 95% CI
CI_poultry_H = func_CI95(bin_H,...
    average_poultry_H_Hootstrap);





%% plots
% https://www.mathworks.com/matlabcentral/answers/443322-fill-the-region-between-two-lines
poultry_W = [bin_W,average_poultry_W,CI_poultry_W];
poultry_W(bin_W > 180,:)=[];

poultry_B = [bin_B,average_poultry_B,CI_poultry_B];
poultry_B(bin_B > 180,:)=[];

poultry_H = [bin_H,average_poultry_H,CI_poultry_H];
poultry_H(bin_H > 180,:)=[];


Poultry_Owner_3km_W = poultry_W;
Poultry_Owner_3km_B = poultry_B;
Poultry_Owner_3km_H = poultry_H;


save('Poultry_Owner_3km_W.mat',...
    'Poultry_Owner_3km_W');
save('Poultry_Owner_3km_B.mat',...
    'Poultry_Owner_3km_B');
save('Poultry_Owner_3km_H.mat',...
    'Poultry_Owner_3km_H');
%%
figure(1)
hold all
% -------------- White -------------- %
F1 = plot(poultry_W(:,1),poultry_W(:,2),...
    'LineWidth',1.4,'color','k');
patch([poultry_W(:,1)' fliplr(poultry_W(:,1)')], ...
    [poultry_W(:,3)' fliplr(poultry_W(:,4)')], ...
    'k','FaceAlpha',0.3);
% -------------- Black -------------- %
F2 = plot(poultry_B(:,1),poultry_B(:,2),...
    'LineWidth',1.4,'color','b');
patch([poultry_B(:,1)' fliplr(poultry_B(:,1)')], ...
    [poultry_B(:,3)' fliplr(poultry_B(:,4)')], ...
    'b','FaceAlpha',0.3);
% -------------- Hispanic -------------- %
F3 = plot(poultry_H(:,1),poultry_H(:,2),...
    'LineWidth',1.4,'color','r');
patch([poultry_H(:,1)' fliplr(poultry_H(:,1)')], ...
    [poultry_H(:,3)' fliplr(poultry_H(:,4)')], ...
    'r','FaceAlpha',0.3);
hold off
legend([F1 F2 F3], ...
    'White','Black', 'Hispanic', ...
    'Location','NE','Fontsize',10)
ylim([0,0.8])
ylabel('Poultry Exposure','FontSize',10)
xlabel('Income (in $1000)','FontSize',10)
title('Poultry Exposure, Owner','FontSize',10)
% saveas(gcf,'Poultry_CI_owner_3km.png')



