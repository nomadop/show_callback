class RainScene < Scene::Base
  attr_accessor :ground_y
  attr_accessor :rain_remains

  def initialize(rain_remains = 100, raining_rate = 0.2)
    super()
    @rain_remains = rain_remains
    @raining_rate = raining_rate
  end

  def start
    super
    create_new_rain
  end

  def update
    super
    create_new_rain if rand < @raining_rate
    finish! if !rain_remain? && @sprites.empty?
  end

  def create_new_rain
    if rain_remain?
      add_sprite(Rain.new)
      @rain_remains -= 1
      sun_raise if @rain_remains == 0
    end
  end

  def sun_raise
    sun = Sun.new
    add_sprite(sun)
    behaviours_chain = Chain.new(sun)
    behaviours_chain
        .add_behaviour { Wait.new(1) }
        .add_behaviour { MoveTo.new(150, 100, 5) }
        .end!
  end

  def rain_remain?
    rain_remains > 0
  end
end