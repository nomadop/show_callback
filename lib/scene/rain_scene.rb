class RainScene < Scene::Base
  attr_accessor :ground_y

  def initialize(rain_remains, raining_rate, ground_y = World::WORLD_HEIGHT - 100)
    super()
    @ground_y = ground_y
    @rain_remains = rain_remains
    @raining_rate = raining_rate
  end

  def start!
    super
    create_bouncing_ball
    create_new_rain
  end

  def create_bouncing_ball
    @bouncing_ball = Ball.new(100, ground_y - 70, 70, Color::RED)
    bouncing_chain = Behaviour::Chain.new(@bouncing_ball)
    bouncing_chain
        .add_behaviour { Bounce.new(-25) }
        .loop!

    swing_chain = Behaviour::Chain.new(@bouncing_ball)
    swing_chain
        .add_behaviour { MoveRight.new(World::WORLD_WIDTH, 15) }
        .add_behaviour { MoveLeft.new(World::WORLD_WIDTH, 15) }
        .loop!

    add_spirit(@bouncing_ball)
  end

  def update
    super
    @raining_rate.times { create_new_rain }
  end

  def create_new_rain
    if rain_remain?
      rain = BallFactory.rain
      rain
          .add_behaviour(MoveDown.new(ground_y, 10).add_callback(Callback.disappear(rain)))
          .add_behaviour(DisappearWhenCollideTarget.new(@bouncing_ball))
      add_spirit(rain)
      @rain_remains -= 1
      sun_raise unless rain_remain?
    end
  end

  def sun_raise
    sun = BallFactory.sun
    sun
        .add_behaviour(Wait.new(3)
        .add_callback(Callback.next_behaviour(sun, MoveTo.new(150, 100, 5)
        .add_callback(Callback.new(@bouncing_ball) do |bouncing_ball|
                        bouncing_ball.clear_behaviours
                        bouncing_ball.add_behaviour(MoveDown.new(ground_y - bouncing_ball.bottom_y))
                      end))))
    add_spirit(sun)
  end

  def rain_remain?
    @rain_remains > 0
  end
end