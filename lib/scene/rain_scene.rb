class RainScene < Scene::Base
  attr_accessor :ground_y
  attr_accessor :rain_remains

  def initialize(rain_remains = 100, raining_rate = 0.2, ground_y = World::WORLD_HEIGHT - 50)
    super()
    @ground_y = ground_y
    @rain_remains = rain_remains
    @raining_rate = raining_rate
  end

  def start!
    super
    create_new_rain
  end

  def update
    super
    @raining_rate.times { create_new_rain }
    finish! if !rain_remain? && @spirits.empty?
  end

  def create_new_rain
    if rain_remain?
      add_spirit(Rain.new)
      @rain_remains -= 1
      sun_raise unless rain_remain?
    end
  end

  def sun_raise
    sun = Sun.new
    sun
        .add_behaviour(Wait.new(3)
        .add_callback(Callback.next_behaviour(sun, MoveTo.new(150, 100, 5))))
    add_spirit(sun)
  end

  def rain_remain?
    rain_remains > 0
  end
end