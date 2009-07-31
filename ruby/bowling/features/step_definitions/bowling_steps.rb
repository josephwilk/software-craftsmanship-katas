When /^I bowl:$/ do |table|
  # table is a Cucumber::Ast::Table
  table.hashes.each do |hash|
    @game.roll(hash['roll 1'])
    @game.roll(hash['roll 2'])
  end
end

When /^I start a new game$/ do
  @game = Bowling::Game.new
end

Then /^I should have a score of (\d+)$/ do |score|
  @game.score.should == score.to_i
end
