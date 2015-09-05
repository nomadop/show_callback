class RainScene < Scene::Base
  attr_accessor :ground_y

  def initialize(rain_remains, raining_rate, ground_height = 100)
    super()
    @ground_y = World::WORLD_HEIGHT - ground_height
    @rain_remains = rain_remains
    @raining_rate = raining_rate
  end

  def start!
    super
    create_bouncing_ball
    create_new_rain
  end

  def create_bouncing_ball
    @bouncing_ball = BallFactory.bouncing_ball_swing_left_and_right(100, 70, Color::RED, 25, 15)
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
          .add_behaviour(DisappearWhenCollidedBy.new(@bouncing_ball))
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