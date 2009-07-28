When /^I bowl:$/ do |table|
  # table is a Cucumber::Ast::Table
  pending
end

When /^my opponent bowls:$/ do |table|
  # table is a Cucumber::Ast::Table
  pending
end

When /^I start a new game$/ do
  @game = Bowling::Game.new
end

Then /^I should see$/ do |string|
  pending
end
