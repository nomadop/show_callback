class Bouncing < Behaviour::Base
  def initialize(init_speed, bouncing_rate = 0.9)
    super()
    @init_speed = init_speed
    @bouncing_rate = bouncing_rate
    @speed = @init_speed
    @acc = 1
  end

  def attach_sprite(sprite)
    super
    bouncing_after_reach_ground
  end

  def update
    @speed += @acc
    @sprite.center_y += [@speed, World::WORLD_HEIGHT - @sprite.half_height - @sprite.center_y].min
  end

  def finish?
    super || @sprite.center_y + @sprite.half_height >= World::WORLD_HEIGHT
  end

  def bouncing_after_reach_ground
    new_init_speed = @init_speed * @bouncing_rate
    if new_init_speed < -@acc
      add_callback(bouncing_callback(new_init_speed))
    end
  end

  def bouncing_callback(new_init_speed)
    Callback.new(@sprite, new_init_speed, @bouncing_rate) do |sprite, init_speed, bouncing_rate|
      sprite.add_behaviour(Bouncing.new(init_speed, bouncing_rate))
    end
  end
end