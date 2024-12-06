function solutionLength = LawnmowerPlanner(scenarioFile, start, plannerType)
    load(scenarioFile, 'map');
    solution = [];
    titleName = "";
    endPos = [1,1];
    if plannerType < 2
        solution = DepthFirstLawnmower(map, plannerType, start);
        titleName = "DFS" + plannerType;
    elseif plannerType == 2
        solution = RandomLawnmower(map,start);
        titleName = "Random";
    elseif plannerType == 3
        titleName = "Optimal";
        solution = OptimalLawnmower(map, start);
    end
    endPos = solution(end, :);

    if endPos ~= [1, 1]
        solution = [solution; AStarNavigate(map, [], endPos, start)];
    end
    writematrix(solution, titleName + "Waypoints.txt");
    animateSolution(titleName, solution, map);
    [solutionLength, ~] = size(solution);

end


function animateSolution(titleName, solution, map)
fprintf("Simulation Complete!\n");
f = figure;
imagesc(map);
title(titleName);
hold on;
gifFile = titleName + '.gif';
cmap = [0 1 0;
    0 0 1; 1 0 0; 1 0 0];
colormap(cmap);
exportgraphics(f, gifFile);
[sr, ~] = size(solution);
for i = 1:sr
    solvePos = solution(i,:);
    r = rectangle('Position',[solvePos(2) - 0.5, solvePos(1) - 0.5,1,1],'FaceColor',[0 .5 .5],'EdgeColor','b',...
        'LineWidth',3);
    pause(0.01);
    delete(r);
    
end
end