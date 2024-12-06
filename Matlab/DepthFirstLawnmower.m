function solution = DepthFirstLawnmower(map, solutionType, startingLocation)
solution = [];



switch solutionType
    case 0
        fprintf('Running an updown first simulation...\n');
        titleName = "UpDown_Solution";
        [solution] = DFS(map, solutionType, startingLocation);

    case 1
        fprintf('Running an leftright first simulation...\n');
        titleName = "LeftRight_Solution";
        [solution] = DFS(map, solutionType, startingLocation);
        
end
end

function solution = DFS(map, type, startingLocation)
solution = [startingLocation];
% always go up first, then down, then left then right
% repeat until all of values that aren't static obstacles have been visited


currPos = startingLocation;

[requiredRows, requiredCols] = find(map ==0);

required = [requiredRows, requiredCols];
fprintf("Finding Index of currPos");
[found, idx] = findIn2dList(required, currPos);
found
idx

done = false;
count = 0;

while ~done
    [rows, ~] = size(required);
    if rows == 0
        break;
    end
    [found, idx] = findIn2dList(required, currPos);
    if found
        required(idx,:) = [];
        count = size(required);
    end
    currPos = getNextPos(type, currPos, required, map);


    map = iterateMap(map);

    solution = [solution; currPos];
    currPos = currPos(end, :);

end


end

function [found, idx] = findIn2dList(list, item)
found = false;
idx = 0;
[sr, sc] = size(list);
for i = 1:sr
    tmp = list(i,:);
    if tmp(1) == item(1) && tmp(2) == item(2)
        found = true;
        idx = i;
        break;
    end
end


end

function newMap = iterateMap(map)
[rows, cols] = size(map);
newMap = map;
for r = 1:rows
    for c = 1:cols
        switch map(c,r)
            case 3

                if (c < cols && ~map(c + 1, r))
                    if ~newMap(c + 1, r)
                        newMap(c+1, r) = 3;
                        newMap(c, r) = 0;
                    else
                        newMap(c, r) = 4;
                    end
                else
                    newMap(c, r) = 4;
                end
            case 4
                if c - 1 > 0 && (~map(c - 1, r))
                    if ~newMap(c - 1, r)
                        newMap(c - 1,r) = 4;
                        newMap(c, r) = 0;
                    else
                        newMap(c, r) = 3;
                    end
                else
                    newMap(c,r) = 3;
                end
            case 5
                if (r < rows && ~map(c, r + 1))
                    if ~newMap(c, r + 1)
                        newMap(c,r + 1) = 5;
                        newMap(c, r) = 0;
                    else
                        newMap(c,r) = 6;
                    end
                else
                    newMap(c,r) = 6;
                end
            case 6
                if r - 1 > 0 && (~map(c, r - 1))
                    if ~newMap(c, r -1)
                        newMap(c,r - 1) = 6;
                        newMap(c, r) = 0;
                    else
                        newMap(c, r) = 5;
                    end
                else
                    newMap(c,r) = 5;
                end
        end

    end
end
end

function pos = getNextPos(type, currPos, requiredVisits, map)
% up = -1
% down = +1
% left = -1
% right = +1
switch type
    case 0
        found = false;
        found1 = false;
        found2 = false;
        found3 = false;
        [sr, sc] = size(map);
        if currPos(1) - 1 > 0
            pos = [currPos(1) - 1, currPos(2)];
            [found, ~] = findIn2dList(requiredVisits, pos);

        end

        if ~found && (currPos(1) + 1 < sr + 1)
            pos = [currPos(1) + 1, currPos(2)];
            [found1, ~] = findIn2dList(requiredVisits, pos);
        end

        if ~found && ~found1 &&(currPos(2) - 1 > 0)
            pos = [currPos(1), currPos(2) - 1];
            [found2, ~] = findIn2dList(requiredVisits, pos);

        end

        if ~found && ~found1 && ~found2 && (currPos(2) + 1 < sc+1)
            pos = [currPos(1), currPos(2) + 1];
            [found3, ~] = findIn2dList(requiredVisits, pos);

        end



        if ~found && ~found1 && ~found2 && ~found3
            pos = moveTowardsNearest(map, currPos, type, requiredVisits, sr, sc);
        end
    case 1
        found = false;
        found1 = false;
        found2 = false;
        found3 = false;
        [sr, sc] = size(map);
        if currPos(2) - 1 > 0
            pos = [currPos(1), currPos(2)-1];
            [found, ~] = findIn2dList(requiredVisits, pos);

        end

        if ~found && (currPos(2) + 1 < sc + 1)
            pos = [currPos(1), currPos(2)+1];
            [found1, ~] = findIn2dList(requiredVisits, pos);
        end

        if ~found && ~found1 &&(currPos(1) - 1 > 0)
            pos = [currPos(1)-1, currPos(2)];
            [found2, ~] = findIn2dList(requiredVisits, pos);

        end

        if ~found && ~found1 && ~found2 && (currPos(1) + 1 < sr+1)
            pos = [currPos(1) + 1, currPos(2)];
            [found3, ~] = findIn2dList(requiredVisits, pos);

        end



        if ~found && ~found1 && ~found2 && ~found3
            pos = moveTowardsNearest(map, currPos, type, requiredVisits, sr, sc);
        end


end

end

function pos = moveTowardsNearest(map, currPos, type, requiredVisits, sr, sc)
closest_dist = inf;
            closest_pos = [currPos(1) - 1, currPos(2)];
            [rows, ~] = size(requiredVisits);

            for i = 1:rows
                tmp = requiredVisits(i,:);
                dx = abs(currPos(1) - tmp(1));
                dy = abs(currPos(2) - tmp(2));
                dist = 1* (dx + dy) + (sqrt(2) - 2 * 1) * min(dx, dy);

                if dist < closest_dist
                    closest_pos = tmp;
                    closest_dist = dist;
                end
            end
            done = false;
            % Need to find direction here, check row first
            if currPos(1) > closest_pos(1)
                if currPos(1) - 1 > 0
                    if ~map(currPos(1) - 1, currPos(2))
                        pos = [currPos(1)-1, currPos(2)];
                        done = true;
                        fprintf("Moving up\n");
                    else
                        done = false;
                    end
                end
            end

            % try moving down
            if currPos(1) < closest_pos(1) && ~done
                if currPos(1) + 1 < sr + 1
                    if ~map(currPos(1) + 1, currPos(2))
                        pos = [currPos(1)+1, currPos(2)];
                        fprintf("Moving down\n");
                        done = true;
                    else
                        done = false;
                    end
                end
            end

            % Need move left or right
            if ~done
                if currPos(2) > closest_pos(2)
                    if currPos(2) - 1 > 0
                        if ~map(currPos(1), currPos(2) - 1)
                            pos = [currPos(1), currPos(2) - 1];
                            done = true;
                            fprintf("Moving Left\n");
                        else
                            done = false;
                        end
                    end
                end
            end
            if ~done
                if currPos(2) + 1 < sc + 1
                    if ~map(currPos(1), currPos(2) + 1)
                        pos = [currPos(1), currPos(2) + 1];
                    end
                end

            end


end

