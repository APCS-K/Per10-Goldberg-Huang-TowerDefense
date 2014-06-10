Per10-Goldberg-Huang-TowerDefense
=================================

Game summary:
Your goal is to prevent enemies from reaching the end of the path. If too many enemies get through, you lose. You kill enemies by clicking to place towers that shoot bullets. If multiple bullets hit an enemy, it loses extra hit points. It costs money to place a tower; if you do not have enough money, you cannot place more towers. You make money by killing enemies. Child enemies come down the path first, followed by their parents, and then their grandparents. Higher generations start with more hit points but lose hit points when you kill their children/grandchildren. For example, a parent enemy may start with 25 HP, but by the time it comes on screen, it may have only 20 HP. When an enemy reaches the end of the path, you lose the same number of lives as hit points it has left. Thus higher generation enemies are likely to lose you more lives if they make it to the end of the path. Money and lives are displayed in the bar on the right.

Game implementation:
A few data structures are used to implement this tower defense game. Enemies are created in a a basic tree structure, and are then pushed on to a stack so that they can be easily released in the right order. A hash table is used to keep track of the hits done to each enemy each turn, to allow for special scoring for multiple hits.

Acknowledgments:
Safacon's youtube tutorials for creation of background and path
Processing website
