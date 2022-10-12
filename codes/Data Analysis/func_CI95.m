
function [CI] = func_CI95(bin,average_hogs)

CI = zeros(size(bin,1),2);
for i = 1:size(bin,1)
    CI(i,1) = prctile(average_hogs(i,:),2.5);
    CI(i,2) = prctile(average_hogs(i,:),97.5);
end

end