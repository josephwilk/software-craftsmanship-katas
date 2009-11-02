Given /^I have a 3x3 universe(?: with a cell at (\d)+x(\d)+)?$/ do |x,y|
  @universe = Universe.new(3,3)
  @universe.create_cell(x.to_i, y.to_i) unless x.nil? && y.nil?
end

Given /^I have a 3x3 universe with cells at:$/ do |table|
  Given "I have a 3x3 universe"
  table.hashes.each do |coordinate|
    @universe.create_cell(coordinate['x'].to_i, coordinate['y'].to_i)
  end
end

When /^1 tick passes$/ do
  @universe.tick
end

Then /^I should see the output:$/ do |string|
  @universe.to_s.should == string
end
