class MoveLeft < Behaviour::Base
  DEFAULT_SPEED = 5

  def initialize(speed = DEFAULT_SPEED)
    super()
    @speed = speed
  end

  def update
    @sprite.center_x -= [@speed, @sprite.center_x - @sprite.half_width].min
  end

  def finish?
    @sprite.center_x <= @sprite.half_width
  end
end