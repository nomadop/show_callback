class MoveUp < Behaviour::Base
  DEFAULT_SPEED = 5

  def initialize(speed = DEFAULT_SPEED)
    super()
    @speed = speed
  end

  def update
    @sprite.center_y -= [@speed, @sprite.center_y - @sprite.half_height].min
  end

  def finish?
    @sprite.center_y <= @sprite.half_height
  end
end