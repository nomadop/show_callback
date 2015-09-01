class MoveUp < SimpleMovement
  DEFAULT_SPEED = 5

  def initialize(distance = World::WORLD_HEIGHT, speed = DEFAULT_SPEED)
    super
  end

  def update
    super
    @sprite.center_y -= move
  end

  def move
    [@speed, @sprite.center_y - @sprite.half_height].min
  end

  def finish?
    super || @sprite.center_y <= @sprite.half_height
  end
end