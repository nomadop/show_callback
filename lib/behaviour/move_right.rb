class MoveRight < SimpleMovement

  def initialize(distance = World::WORLD_WIDTH, speed = DEFAULT_SPEED)
    super
  end

  def action
    super
    @spirit.center_x += move
  end

  def move
    [@speed, World::WORLD_WIDTH - @spirit.half_width - @spirit.center_x].min
  end

  def finish?
    super || @spirit.center_x + @spirit.half_width >= World::WORLD_WIDTH
  end

end