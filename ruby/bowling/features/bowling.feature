Feature: Bowling

  Scenario: Normal score points
    When I start a new game
    And I bowl:
      |score 1|score2|
      |   5   |  0   |
      |   1   |  2   |
    And my opponent bowls:
      |score 1|score2|
      |   5   |  0   |
      |   0   |  0   |
    Then I should have a score of 7
    And the opponent should have a score of 5
