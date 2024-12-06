function solution = OptimalLawnmower(map, startingPos)
solution = [startingPos];
% always go up first, then down, then left then right
% repeat until all of values that aren't static obstacles have been visited

[sr, sc] = size(map);
currPos = startingPos;

[requiredRows, requiredCols] = find(map ==0);

required = [requiredRows, requiredCols];
% Sort the list to get to the bottom right corner first
required = sortrows(required, [-1, -2]);

done = false;
count = 0;

while ~done
    [rows, ~] = size(required)
    if rows == 0
        break;
    end
    % AStar search to the first required position, clearing out any
    % unvistited paths along the way. keep doing this until its gone, it
    % should end right next to the start position
    [found, idx] = findIn2dList(required, currPos);
    if found
        required(idx,:) = [];
    end
    path = AStarNavigate(map, required, currPos, required(1,:));
    [rows, ~] = size(path);
    for i = 1:rows
        [found, idx] = findIn2dList(required, path(i, :));
    if found
        required(idx,:) = [];
    end
    end
    solution = [solution; path];
    currPos = path(end, :);

end
end