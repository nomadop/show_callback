class Bounce < Behaviour::Base
  def initialize(init_speed, bouncing_rate = 0.9)
    super()
    @init_speed = init_speed
    @bouncing_rate = bouncing_rate
    @speed = @init_speed
    @acc = 1
  end

  def attach_spirit(spirit)
    super
    bounce_after_reach_ground
  end

  def update
    @speed += @acc
    @spirit.center_y += [@speed, World::WORLD_HEIGHT - @spirit.half_height - @spirit.center_y].min
  end

  def finish?
    @spirit.center_y + @spirit.half_height >= World::WORLD_HEIGHT
  end

  def bounce_after_reach_ground
    new_init_speed = @init_speed * @bouncing_rate
    add_callback(bounce_callback(new_init_speed)) if new_init_speed < -@acc
  end

  def bounce_callback(new_init_speed)
    Callback.new(@spirit, new_init_speed, @bouncing_rate) do |spirit, init_speed, bouncing_rate|
      spirit.add_behaviour(Bounce.new(init_speed, bouncing_rate))
    end
  end
end