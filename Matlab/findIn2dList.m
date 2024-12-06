function [found, idx] = findIn2dList(list, item)
found = false;
idx = 0;
[sr, ~] = size(list);
for i = 1:sr
    tmp = list(i,:);
    if tmp(1) == item(1) && tmp(2) == item(2)
        found = true;
        idx = i;
        break;
    end
end


end