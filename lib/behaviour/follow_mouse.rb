class FollowMouse < Behaviour::Base
  MIN_SPEED = 2

  def initialize(min_speed = MIN_SPEED)
    @min_speed = min_speed
  end

  def action
    @spirit.center_x += move_x
    @spirit.center_y += move_y
  end

  def move_x
    move = Math.cos(radian) * speed
    [move, World.mouse.x - @spirit.center_x].min_by(&:abs)
  end

  def move_y
    move = Math.sin(radian) * speed
    [move, World.mouse.y - @spirit.center_y].min_by(&:abs)
  end

  def radian
    (angle / 180.0) * Math::PI
  end

  def angle
    Gosu.angle(@spirit.center_x, @spirit.center_y, World.mouse.x, World.mouse.y) - 90.0
  end

  def speed
    [@spirit.center.distance_to(World.mouse) / 100, @min_speed].max
  end
end