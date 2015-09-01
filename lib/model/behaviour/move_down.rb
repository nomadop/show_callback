class MoveDown < SimpleMovement

  def initialize(distance = World::WORLD_HEIGHT, speed = DEFAULT_SPEED)
    super
  end

  def update
    super
    @sprite.center_y += move
  end

  def move
    [@speed, World::WORLD_HEIGHT - @sprite.half_height - @sprite.center_y].min
  end

  def finish?
    super || @sprite.center_y + @sprite.half_height >= World::WORLD_HEIGHT
  end
end