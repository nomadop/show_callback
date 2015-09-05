class Point < Struct.new(:x, :y)
  class << self
    def pedal(from, to, point)
      a = to.y - from.y
      b = from.x - to.x
      c = to.x * from.y - from.x * to.y

      (a * point.x + b * point.y + c).to_f / (a**2 + b**2)**0.5
    end
  end

  def move(x, y)
    self.x += x
    self.y += y
  end
end