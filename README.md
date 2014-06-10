Per10-Goldberg-Huang-TowerDefense
=================================

Majority of work is in TowerDefense folder; Sketch1 contains some functions we may want to copy over.

Complete:
Background layout/creation of path
Highlighting squares
Placing towers
Enemies traveling down path
Shooting bullets
Make bullets do damage to enemies
Implement scoring system for enemies

To do:
Implement monetary system for buying towers


Game summary:
Your goal is to prevent enemies from reaching the end of the path. If too many enemies get through, you lose. You kill enemies by placing towers that shoot bullets. If multiple bullets hit an enemy, it loses extra hit points. It costs money to place a tower; if you do not have enough money, you cannot place more towers. You make money by killing enemies. Child enemies come down the path first, followed by their parents, and then their grandparents. Higher generations lose hit points when you kill their children/grandchildren. For example, a parent enemy may start with 25 HP, but by the time it comes on screen, it may have only 20 HP. When an enemy reaches the end of the path, you lose the same number of lives as hit points it has left. Thus Higher generation enemies are likely to cause you to lose more lives if they make it to the end of the path. Money and lives are displayed in the bar on the right.

Acknowledgments:
Safacon's youtube tutorials for creation of background and path
Processing website
