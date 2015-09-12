class Line < Spirit::Base
  attr_accessor :length
  attr_accessor :weight

  def initialize(center_x, center_y, length, weight, color, angle = 0.0)
    super(World.line_image)
    @length = length.to_f
    @weight = weight.to_f
    @color = color
    @angle = angle.to_f
    @center_x = center_x.to_f
    @center_y = center_y.to_f
  end

  def head
    backslash? ? upper_left : lower_left
  end

  def tail
    backslash? ? lower_right : upper_right
  end

  def backslash?
    @angle.between?(0.0, 90.0) || @angle.between?(180.0, 270.0)
  end

  def draw
    super
    if @weight > 3
      circle = World.circle_image
      scale = @weight / Graphic::DEFAULT_RADIUS / 2
      circle.draw_rot(head.x, head.y, @z_index, 0.0, 0.5, 0.5, scale, scale, @color)
      circle.draw_rot(tail.x, tail.y, @z_index, 0.0, 0.5, 0.5, scale, scale, @color)
    end
  end

  def scale_x
    @length / Graphic::DEFAULT_LENGTH
  end

  def scale_y
    @weight / Graphic::DEFAULT_WEIGHT
  end

  def width
    (@length * Math.cos(radian)).abs
  end

  def width=(_)
    fail "Please use `length=` instead"
  end

  def height
    (@length * Math.sin(radian)).abs
  end

  def height=(_)
    fail "Please use `weight=` instead"
  end
end