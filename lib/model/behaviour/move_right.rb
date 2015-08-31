class MoveRight < Behaviour::Base
  DEFAULT_SPEED = 5

  def initialize(speed = DEFAULT_SPEED)
    super()
    @speed = speed
  end

  def update
    @sprite.center_x += [@speed, World::WORLD_WIDTH - @sprite.half_width - @sprite.center_x].min
  end

  def finish?
    @sprite.center_x + @sprite.half_width <= World::WORLD_WIDTH
  end
end