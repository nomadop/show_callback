class SimpleMovement < Behaviour::Base
  DEFAULT_SPEED = 10

  def initialize(distance, speed)
    super()
    @speed = speed
    @distance = distance
    @moved = 0
  end

  def update
    @moved += move
  end

  def finish?
    @moved >= @distance
  end
end