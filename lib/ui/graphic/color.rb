class Color < Struct.new(:red, :green, :blue)
  BLACK = new(0, 0, 0)
  RED = new(255, 0, 0)
  GREEN = new(0, 255, 0)
  BLUE = new(0, 0, 255)
  ORANGE = new(255, 255, 0)
  YELLOW = new(0, 255, 255)
  PURPLE = new(255, 0, 255)
  WHITE = new(255, 255, 255)

  def to_ascii
    "#{ASCII.at(red)}#{ASCII.at(green)}#{ASCII.at(blue)}"
  end

  def to_s
    "#{hex[:red]}#{hex[:green]}#{hex[:blue]}"
  end

  def hex
    @hex || @hex = {red: format_to_hex(red), green: format_to_hex(green), blue: format_to_hex(blue)}
  end

  def format_to_hex(integer)
    "%02X" % integer
  end
end