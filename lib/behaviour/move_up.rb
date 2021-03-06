class MoveUp < SimpleMovement

  def initialize(distance = World::WORLD_HEIGHT, speed = DEFAULT_SPEED)
    super
  end

  def action
    super
    @spirit.center_y -= move
  end

  def move
    [@speed, @spirit.center_y - @spirit.half_height].min
  end

  def finish?
    super || @spirit.center_y <= @spirit.half_height
  end

end