class RainScene < Scene::Base
  attr_accessor :ground_y

  def initialize(rain_remains, raining_rate, ground_height = 100)
    super()
    @ground_y = World::WORLD_HEIGHT - ground_height
    @drop_remains = rain_remains
    @raining_rate = raining_rate
    @raining_started = false
    @ground_line = '-' * (World::WORLD_WIDTH / 12)
  end

  def start!
    super
    create_sun
    create_bouncing_ball
  end

  def create_bouncing_ball
    @bouncing_ball = BallFactory.bouncing_ball_swing_left_and_right(100, 70, Color::GREEN, 25, 15)
    add_spirit(@bouncing_ball)
  end

  def rain_start!
    @raining_started = true
  end

  def rain_start?
    @raining_started
  end

  def update
    super
    @raining_rate.times { create_drop } if rain_start? && drop_remain?
  end

  def draw
    super
    World.window.default_font.draw(@ground_line, 0, ground_y - 24, 1)
    World.window.default_font.draw("Drop Remains: #{@drop_remains}", 20, World::WORLD_HEIGHT - 50, 1)
  end

  def create_drop
    if drop_remain?
      @drop_remains -= 1
      drop_speed = 10
      drop = BallFactory.drop
      drop
          .add_behaviour(MoveDown.new(ground_y, drop_speed)
            .add_callback(CallbackFactory.disappear(drop)))
          .add_behaviour(CollideWith.new(@bouncing_ball)
            .add_callback(CallbackFactory.disappear(drop)))
      add_spirit(drop)
    end
  end

  def create_sun
    sun = BallFactory.sun(center_x: 200, center_y: 150, radius: 150)
    sun
        .add_behaviour(Wait.new(2)
          .add_callback(CallbackFactory.next_behaviour(sun, MoveTo.new(-150, -100, 5)
            .add_callback(CallbackFactory.next_behaviour(sun, Wait.new(1)
              .add_callback(lambda { rain_start! }))))))
    add_spirit(sun)
  end

  def drop_remain?
    @drop_remains > 0
  end
end