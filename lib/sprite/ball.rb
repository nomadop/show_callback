class Ball < Spirit::Base
  DEFAULT_RADIUS = 50

  attr_accessor :radius

  def initialize(center_x, center_y, radius, color)
    super(World.circle_image(radius, color))
    @center_x = center_x
    @center_y = center_y
    @radius = radius
  end

  def height
    @radius * 2
  end

  def height=(height)
    @radius = height / 2
  end

  def width
    height
  end

  def width=(width)
    self.height = width
  end

  def collide?(other)
    other.is_a?(Ball) ? center.distance_to(other.center) <= @radius + other.radius : super
  end
end