class MoveLeft < SimpleMovement
  DEFAULT_SPEED = 5

  def initialize(distance = World::WORLD_WIDTH, speed = DEFAULT_SPEED)
    super
  end

  def update
    super
    @spirit.center_x -= move
  end

  def move
    [@speed, @spirit.center_x - @spirit.half_width].min
  end

  def finish?
    super || @spirit.center_x <= @spirit.half_width
  end
end