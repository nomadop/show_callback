class Point < Struct.new(:x, :y)
  class << self
    def pedal(from, to, point)
      a = to.y - from.y
      b = from.x - to.x
      c = to.x * from.y - from.x * to.y

      (a * point.x + b * point.y + c).to_f / (a**2 + b**2)**0.5
    end

    def distance(point1, point2)
      vec = vector(point1, point2)
      (vec.x**2 + vec.y**2)**0.5
    end

    def vector(point1, point2)
      new(point2.x - point1.x, point2.y - point1.y)
    end
  end

  def move(x, y)
    self.x += x
    self.y += y
  end

  def distance_to(other)
    Point.distance(self, other)
  end
end