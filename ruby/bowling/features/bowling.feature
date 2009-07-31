Feature: Bowling
In order to gloat to my mates
As an avid bowler
I want to keep track of my bowling prowess

  Scenario: Normal score points
    When I start a new game
    And I bowl:
      |score 1|score2|
      |   5   |  4   |
    Then I should have a running score of 9

