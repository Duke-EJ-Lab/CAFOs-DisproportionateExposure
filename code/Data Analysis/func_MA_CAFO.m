function [average_hogs] = func_MA_CAFO(bin,hogs_sample)

average_hogs = zeros(size(bin,1),1);

for i = 21:size(bin,1)-30
    group = find(hogs_sample(:,1) >= bin(i - 20) & ...
        hogs_sample(:,1) <= bin(i + 30));
    average_hogs(i) = mean(hogs_sample(group,2));
end

%{
group = find(hogs_sample(:,1) >= bin(1) & ...
        hogs_sample(:,1) <= bin(30));
average_hogs(1) = mean(hogs_sample(group,2));
%}

for i = 1:20
    group = find(hogs_sample(:,1) >= bin(1) & ...
        hogs_sample(:,1) <= bin(i + 30));
    average_hogs(i) = mean(hogs_sample(group,2));
end

for i = size(bin,1)-31:size(bin,1)
    group = find(hogs_sample(:,1) >= bin(i - 20) & ...
        hogs_sample(:,1) <= bin(size(bin,1)));
    average_hogs(i) = mean(hogs_sample(group,2));
end

end