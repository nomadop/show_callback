class Bounce < Behaviour::Base
  def initialize(speed)
    super()
    @speed = -speed
    @acc = 1
  end

  def attach_spirit(spirit)
    super
    @start_y = spirit.center_y
  end

  def update
    @speed += @acc
    @spirit.center_y += move
  end

  def move
    [@speed, @start_y - @spirit.center_y].min
  end

  def finish?
    @spirit.center_y >= @start_y
  end
end