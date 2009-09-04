$:.unshift(File.dirname(__FILE__) + '/../lib/')

require 'bowling'

module Rolling
  def having_rolled(*pins)
    pins.each {|pins_down| @game.roll(pins_down)}
    yield
  end
end
