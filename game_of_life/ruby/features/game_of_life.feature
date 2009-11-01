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
