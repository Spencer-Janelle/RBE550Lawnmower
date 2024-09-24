function map = GenerateScenario(modelNum, size, numObstacles, numMoving, homeLocation)
   map = [];
   % 0 = no obstacle
   % 1 = home position
   % 2 = static obstacle
   % 3 = mobile obstacle in X+
   % 4 = mobile obstacle in X-
   % 5 = mobile obstacle in Y+
   % 6 = mobile obstacle in Y-
   
    switch modelNum
        case 0
            fprintf('Creating square lawn...\n');
            map = squareLawn(size);

        case 1
            fprintf('Creating circle lawn...\n');
            map = circleLawn(size);
       
        case 2
            fprintf('Creating L shaped lawn...\n');
            map = lShapeLawn(size);
    end
    map(homeLocation(1), homeLocation(2)) = 1;
    map = populateObstacles(map, size, numObstacles, numMoving);
    animateLawn(map);
end

function [map] = squareLawn(size)
    map = zeros(size);
    
end


function [map] = circleLawn(diameter)
    map = zeros(diameter);
    map(:) = 2;
    for r = 1:diameter
        for c = 1:diameter
            if sqrt((r - diameter/2)^2 + (c - diameter/2)^2)<= diameter/2
                map(c, r) = 0;
            end
        end
    end

end


function [map] = lShapeLawn(size)
    map = zeros(size*2);
    for r = size:size*2
        for c = 1:size*1.5
            map(c, r) = 2;
        end
    end

    
end

function map = populateObstacles(map, size, numObstacles, numMoving)
        for i = 0:numObstacles
            [x, y] = getValidObstacle(map, size);
            map(x, y) = 2;
            map(x + 1, y) = 2;
            map(x, y + 1) = 2;
            map(x + 1, y + 1) = 2;

        end
        for i = 0:numMoving
            typeMove = randi([3,6]);
            [x, y] = getValidObstacle(map, size);
            map(x, y) = typeMove;
            map(x + 1, y) = typeMove;
            map(x, y + 1) = typeMove;
            map(x + 1, y + 1) = typeMove;
        end
            
    
end

function [x, y] = getValidObstacle(map, size)
        done = false;
           while ~done
            x = randi(size-1, 1);
            y = randi(size-1, 1);
            if ~map(x, y) && ~map(x + 1, y) && ~map(x, y + 1) && ~map(x + 1, y + 1)
                done = true;
               
            end
        end 
end

function animateLawn(map)
    figure;
    imagesc(map);
         
end