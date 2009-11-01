Feature: Rendering the Game of life universe
  In order to understand the simulation of life
  As a developer
  I want to see what the universe looks like at different times

Scenario: Empty universe
  Given I have a 3x3 universe
  When 1 tick passes
  Then I should see the output:
    """
    ...
    ...
    ...

    """

Scenario: Single cell in a universe, dying due to underpopulation
  Given I have a 3x3 universe with a cell at 1x1
  When 1 tick passes
  Then I should see the output:
    """
    ...
    ...
    ...

    """

Scenario: Cell dying due to overcrowding
  Given I have a 3x3 universe with cells at:
    | x | y |
    | 1 | 0 |
    | 0 | 1 |
    | 1 | 1 |
    | 2 | 1 |
    | 1 | 2 | 
  When 1 tick passes
  Then I should see the output:
    """
    .x.
    x.x
    .x.

    """
