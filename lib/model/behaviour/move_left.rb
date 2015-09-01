class MoveLeft < SimpleMovement
  DEFAULT_SPEED = 5

  def initialize(distance = World::WORLD_WIDTH, speed = DEFAULT_SPEED)
    super
  end

  def update
    super
    @sprite.center_x -= move
  end

  def move
    [@speed, @sprite.center_x - @sprite.half_width].min
  end

  def finish?
    super || @sprite.center_x <= @sprite.half_width
  end
end