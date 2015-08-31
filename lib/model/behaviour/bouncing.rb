class Bouncing < Behaviour::Base
  def initialize(init_speed)
    super()
    @init_speed = init_speed
    @speed = @init_speed
    @acc = 1

    bouncing_after_reach_ground
  end

  def update
    @speed += @acc
    @sprite.center_y += [@speed, World::WORLD_HEIGHT - @sprite.half_height - @sprite.center_y].min

    # puts @sprite.behaviours.size if finish?
  end

  def finish?
    @sprite.center_y + @sprite.half_height >= World::WORLD_HEIGHT
  end

  def bouncing_after_reach_ground
    new_init_speed = @init_speed * 0.8
    if new_init_speed > 1
      add_callback Callback.new(new_init_speed) do |behaviour, init_speed|
        puts "callback called"
        # behaviour.sprite.remove_behaviour(behaviour)
        behaviour.sprite.add_behaviour(Bouncing.new(init_speed))
      end
    end
  end
end