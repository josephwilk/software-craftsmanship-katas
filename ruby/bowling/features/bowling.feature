Feature: Bowling

  Scenario: Winning game
    When I start a new game
    And I bowl:
      |score 1|score2|
      |   5   |  0   |
      |   1   |  2   |
    And my opponent bowls:
      |score 1|score2|
      |   5   |  0   |
      |   0   |  0   |
    Then I should see
    """
    You (7)
    | 5 0 | 1 2 |
    | 5   | 3   |

    Computer (5)
    | 5 0 | 0 0 |
    | 0   | 0   |

    You wins by 2 points.
  """