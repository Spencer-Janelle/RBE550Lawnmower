ScenarioGenerator:

Usage: The Scenario Generator is used to create lawns for the Gazebo + Matlab Planners. It has 3 supported lawn types:

1: Square
2: Circle
3: L Shaped

It is run in MATLAB 2023, but does not use any special libraries, so any version should be fine.
GenerateScenario(<lawnType>, <lawnSize>, <numStaticObstacles>, <numDynamicObstacles>, <dontAnimateGifBool>)

To create a 50x50 Square lawn with 25 static obstacles
GenerateScenario(0, 50, 25, 0, True)

Outputs: A .txt file containing the map, and a matlab variable with the map. Store the matlab variable for future use if desired.

-----------------------------------------------------------------------------------------

LawnmowerPlanner:

Usage: The Lawnmower Planner is used to generate a waypoint list for the Gazebo model, as well as animate the solution.

There are 5 planners that were implemented:

0: DFS Up/Down
1: DFS Left/Right
2: Random Movements
3: Random A* through Unvisited List
4: Custom A* search through sorted Unvisited List

There are .mat files that have already been pre-generated for your use, and are inputs to the planner.

LawnmowerPlanner(<scenarioFile.mat>, <startPos>, <plannerType>)

NOTE: start positions must be valid in order for the planner to work.

Outputs: A .txt file of waypoints for the Gazebo implementation to navigate, as well as an animation of the solution