
function solution = AStarNavigate(map, required, start, goal)
solution = [];
vehicle.pos = start;
vehicle.f = 0;
vehicle.g = 0;
vehicle.h = 0;
vehicle.parent = 0;
open = [vehicle];
closed = [];


while ~isempty(open)
    vehicle = open(1);
    open(1) = [];
    closed = [closed; vehicle];
    vPos = vehicle.pos;
    if vPos(1) == goal(1) && vPos(2) == goal(2)
        % We are done!
        endV = vehicle;
        break;
    end
    open = expand(map, required, vehicle, open, closed, goal);
end
solution = [];
tmp = endV;
while isa(tmp, 'struct')
    solution = [solution; tmp.pos];
    tmp = tmp.parent;
end
solution = flip(solution);
end

function open = expand(map, required, currVehicle, open, closed, goalPos)
tmpBest = inf;
for i=0:3
    dir = i;
    vehicle = stepVehicleInDir(dir, map, currVehicle);
    if ~map(vehicle.pos(1), vehicle.pos(2))
        vehicle.g = currVehicle.g + getCost(map, required, vehicle);
        vehicle.h = getHueristic(goalPos, vehicle);
        vehicle.f = vehicle.g + vehicle.h;
        % add to open list
        if ~isVehicleInList(closed, vehicle)
            open = addVehicleToOpen(open, vehicle);
        end
    end

end

end

function found = isVehicleInList(list, vehicle)
found = false;
axlePos = vehicle.pos;
for i=1:length(list)
    tmp = list(i).pos;
    if tmp(1) == axlePos(1) && tmp(2) == axlePos(2)
        found = true;
        break;
    end
end
end


function cost = getCost(map, required, vehicle)
cost = 0;
[found, ~] = findIn2dList(required, vehicle.pos);

if ~found
    cost = cost + 2.5;
end

end

function hcost = getHueristic(goalPos, vehicle)
q = vehicle.pos;
dx = abs(q(1) - goalPos(1));
dy = abs(q(2) - goalPos(2));
hcost = 1* (dx + dy) + (sqrt(2) - 2 * 1) * min(dx, dy);
end

function newOp = addVehicleToOpen(op, vehicle)
inlist = false;
if isVehicleInList(op, vehicle)
    inlist = true;
end
newOp = [];
if ~isempty(op)
    if inlist
        axlePos = vehicle.pos;
        for i = 1:length(op)
            tmp = op(i).pos;
            if tmp(1) == axlePos(1) && tmp(2) == axlePos(2)
                if op(i).f > vehicle.f
                    op(i) = [];
                    break;
                else
                    newOp = op;
                    return;
                end
            end

        end
    end
    for i = 1:length(op)
        if op(i).f > vehicle.f
            newOp = [newOp; vehicle; op(i:length(op))];
            return;
        end
        newOp = [newOp; op(i)];
    end
end
newOp = [newOp; vehicle];

end

function vehicle = stepVehicleInDir(dir, map, currVehicle)
vehicle = currVehicle;
[sr, sc] = size(map);
pos = currVehicle.pos;
vehicle.pos = pos;
switch dir
    case 0
        if pos(1) - 1 > 0
            vehicle.pos(1) = pos(1) - 1;
        end

    case 1
        if pos(1) + 1 <= sr
            vehicle.pos(1) = pos(1) + 1;
        end

    case 2
        if pos(2) - 1 > 0
            vehicle.pos(2) = pos(2) - 1;
        end

    case 3
        if pos(2) + 1 <= sc
            vehicle.pos(2) = pos(2) + 1;
        end
end
vehicle.parent = currVehicle;
end