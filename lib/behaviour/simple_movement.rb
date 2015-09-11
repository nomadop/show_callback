class SimpleMovement < Behaviour::Base
  DEFAULT_SPEED = 10

  def initialize(distance, speed)
    super()
    @speed = speed
    @distance = distance || 0
    @moved = 0
  end

  def update
    @moved += move
  end

  def finish?
    @distance > 0 ? @moved >= @distance : false
  end
end