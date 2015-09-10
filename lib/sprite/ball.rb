class Ball < Spirit::Base
  DEFAULT_RADIUS = 50

  attr_accessor :radius

  def initialize(center_x, center_y, radius, color)
    super(World.create_image(Graphic::Circle))
    @center_x = center_x
    @center_y = center_y
    @color = color
    self.radius = radius
  end

  def radius=(radius)
    @radius = radius
    @scale_x = radius.to_f / Graphic::DEFAULT_RADIUS
    @scale_y = radius.to_f / Graphic::DEFAULT_RADIUS
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
    other.is_a?(Ball) ? center.distance_to(other.center) <= radius + other.radius : super
  end
end