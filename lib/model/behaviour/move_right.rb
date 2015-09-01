class MoveRight < SimpleMovement
  DEFAULT_SPEED = 5

  def initialize(distance = World::WORLD_WIDTH, speed = DEFAULT_SPEED)
    super
  end

  def update
    super
    @sprite.center_x += move
  end

  def move
    [@speed, World::WORLD_WIDTH - @sprite.half_width - @sprite.center_x].min
  end

  def finish?
    super || @sprite.center_x + @sprite.half_width >= World::WORLD_WIDTH
  end
end