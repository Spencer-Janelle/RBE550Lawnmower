function map = GenerateScenario(modelNum, size, numObstacles, numMoving)
   map = [];
   % 0 = no obstacle
   % 2 = static obstacle
   % 3 = mobile obstacle in X+
   % 4 = mobile obstacle in X-
   % 5 = mobile obstacle in Y+
   % 6 = mobile obstacle in Y-
   titleName = "";
   
    switch modelNum
        case 0
            fprintf('Creating square lawn...\n');
            map = squareLawn(size);
            titleName = "SquareLawnScenario";

        case 1
            fprintf('Creating circle lawn...\n');
            map = circleLawn(size);
            titleName = "CircleLawnScenario";
       
        case 2
            fprintf('Creating L shaped lawn...\n');
            map = lShapeLawn(size);
            size = size*2;
            titleName = "L ShapedLawnScenario";
    end
    map = populateObstacles(map, size, numObstacles, numMoving);
    animateLawn(map, titleName);
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

function newMap = iterateLawn(map)
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

function animateLawn(map, titleName)
    f = figure;
    imagesc(map);
    title(titleName);
    hold on;
    gifFile = titleName + '.gif';
    cmap = [0 1 0;
        0 0 1; 1 0 0; 1 0 0];
    colormap(cmap);
    exportgraphics(f, gifFile);
    
    for i = 1:50
        fprintf('Iteration %u of %u\n', i, 50);
       map = iterateLawn(map); 
       imagesc(map);
       exportgraphics(f, gifFile, Append=true);
       
        
    end
        
         
end