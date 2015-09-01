class MoveTo < Behaviour::Base
  def initialize(target_x, target_y, speed, *callbacks)
    super(*callbacks)
    @target_x = target_x
    @target_y = target_y
    @speed = speed
  end

  def update
    return if finish?

    @sprite.center_x += speed_x
    @sprite.center_y += speed_y
  end

  def distance_x
    @target_x - @sprite.center_x
  end

  def distance_y
    @target_y - @sprite.center_y
  end

  def distance
    (distance_x**2 + distance_y**2)**0.5
  end

  def speed_x
    @speed.to_f * distance_x.to_f / distance.to_f
  end

  def speed_y
    @speed.to_f * distance_y.to_f / distance.to_f
  end

  def finish?
    (@sprite.center_x - @target_x).abs < speed_x.abs && (@sprite.center_y - @target_y).abs < speed_y.abs
  end
end