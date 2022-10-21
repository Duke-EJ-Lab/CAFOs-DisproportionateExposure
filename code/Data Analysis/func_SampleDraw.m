
function [hogs_sample] = func_SampleDraw(bin,Data)

income = Data(:,1);

hogs_sample = zeros(1,2);

for i = 1:size(bin,1)
  sample = Data(income == bin(i),:);
  s = 1:size(sample,1);
  s = randsample(s,size(sample,1),true);
  s = sort(s);
  hogs_sample(size(hogs_sample,1): ...
      size(hogs_sample,1) + size(s,2) - 1,:) ...
      = sample(s,:);
end


end