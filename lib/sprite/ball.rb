class Ball < Spirit::Base
  DEFAULT_RADIUS = 50

  attr_accessor :radius

  def initialize(center_x, center_y, radius, color)
    super(World.circle_image)
    @center_x = center_x
    @center_y = center_y
    @color = color
    @radius = radius.to_f
  end

  def scale_x
    radius / Graphic::DEFAULT_RADIUS
  end

  def scale_y
    radius / Graphic::DEFAULT_RADIUS
  end

  def height
    radius * 2
  end

  def height=(height)
    self.radius = height / 2
  end

  def width
    radius * 2
  end

  def width=(width)
    self.radius = width / 2
  end

  def collide?(other)
    case other
    when Ball
      center.distance_to(other.center) <= radius + other.radius
    when Line
      Point.pedal(other.head, other.tail, center) <= radius + other.weight / 2
    else
      super
    end
  end
end