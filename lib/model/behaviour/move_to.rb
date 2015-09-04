class MoveTo < Behaviour::Base
  def initialize(target_x, target_y, speed, *callbacks)
    super(*callbacks)
    @target_x = target_x
    @target_y = target_y
    @speed = speed
  end

  def update
    return if finish?

    @spirit.center_x += [speed_x, @target_x - @spirit.center_x].min_by(&:abs)
    @spirit.center_y += [speed_y, @target_y - @spirit.center_y].min_by(&:abs)
  end

  def distance_x
    @target_x - @spirit.center_x
  end

  def distance_y
    @target_y - @spirit.center_y
  end

  def distance
    (distance_x**2 + distance_y**2)**0.5
  end

  def speed_x
    speed_x = @speed.to_f * distance_x.to_f / distance.to_f
    speed_x.to_s == 'NaN' ? 0.0 : speed_x
  end

  def speed_y
    speed_y = @speed.to_f * distance_y.to_f / distance.to_f
    speed_y.to_s == 'NaN' ? 0.0 : speed_y
  end

  def finish?
    (@spirit.center_x - @target_x).abs < 0.01 && (@spirit.center_y - @target_y).abs < 0.01
  end

  def to_s
    "Behaviour MoveTo: #{@target_x}, #{@target_y}"
  end
end