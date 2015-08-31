class Ball < Sprite::Base

  def initialize(center_x, center_y, radius, color)
    super(World.create_image(Circle.create(radius, color)))
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
    @radius * 2
  end

  def width=(width)
    @radius = width / 2
  end
end