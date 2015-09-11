class MoveDown < SimpleMovement

  def initialize(distance = World::WORLD_HEIGHT, speed = DEFAULT_SPEED)
    super
  end

  def update
    super
    @spirit.center_y += move
  end

  def move
    [@speed, World::WORLD_HEIGHT - @spirit.half_height - @spirit.center_y].min
  end

  def finish?
    super || @spirit.center_y + @spirit.half_height >= World::WORLD_HEIGHT
  end

end