Feature: Bowling
In order to gloat to my mates
As an avid bowler
I want to keep track of my bowling prowess

  Scenario: 10 rounds
    When I start a new game
    And I bowl:
      |roll 1|roll 2|
      |5|4|
      |0|0|
      |10||
      |2|3|
      |7|3|
      |5|4|
      |0|10|
      |0|3|
      |8|1|
      |1|1|
    Then I should have a score of 67
