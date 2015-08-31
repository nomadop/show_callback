class MoveDown < Behaviour::Base
  DEFAULT_SPEED = 5

  def initialize(speed = DEFAULT_SPEED)
    super()
    @speed = speed
  end

  def update
    @sprite.center_y += [@speed, World::WORLD_HEIGHT - @sprite.half_height - @sprite.center_y].min
  end

  def finish?
    @sprite.center_y + @sprite.half_height <= World::WORLD_HEIGHT
  end
end