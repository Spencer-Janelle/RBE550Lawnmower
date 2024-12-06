function solution = RandomLawnmower(map, startingPos)
solution = [startingPos];
% always go up first, then down, then left then right
% repeat until all of values that aren't static obstacles have been visited

[sr, sc] = size(map);
currPos = startingPos;

[requiredRows, requiredCols] = find(map ==0);

required = [requiredRows, requiredCols];
fprintf("Finding Index of currPos");
[found, idx] = findIn2dList(required, currPos);
found
idx

done = false;
count = 0;

while ~done
    [rows, ~] = size(required)
    if rows == 0
        break;
    end
    [found, idx] = findIn2dList(required, currPos);
    if found
        required(idx,:) = [];
    end
    dir = randi([0, 3], 1);
    possible = false;
    pos = currPos;
    switch dir
        case 0
            pos(1) = currPos(1) - 1;

            if pos(1) > 0 && ~map(pos(1), pos(2))
                currPos = pos;
                possible = true;

            end

        case 1
            pos(1) = currPos(1) + 1;

            if pos(1) <= sr && ~map(pos(1), pos(2))
                currPos = pos;
                possible = true;

            end

        case 2
            pos(2) = currPos(2) - 1;

            if pos(2) > 0 && ~map(pos(1), pos(2))
                currPos = pos;
                possible = true;
            end

        case 3
            pos(2) = currPos(2) + 1;
            if pos(2) <= sc && ~map(pos(1), pos(2))
                currPos = pos;
                possible = true;
            end
    end
    if possible
        solution = [solution; currPos];
    end
end

end