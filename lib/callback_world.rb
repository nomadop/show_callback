class CallbackWorld
  class << self
    def initialize
      World.new(caption: "Behaviours Callback Demo")

      showcase_scene = ShowcaseScene.new
      rain_scene = RainScene.new(3000, 5)

      World
          .add_scene(ControlScene)
          .add_scene(rain_scene)
          .add_scene(showcase_scene)

      add_case1(showcase_scene)
      add_case2(showcase_scene)
      add_case3(showcase_scene)
      add_case4(showcase_scene)
    end

    def add_case1(showcase_scene)
      showcase_scene.add_case('Bouncing Balls with a reduce rate') do
        init_speed = 35
        bouncing_ball1 =
            BallFactory.bouncing_ball_with_a_reduce_rate(
                280, Ball::DEFAULT_RADIUS, Color::RED, init_speed, 0.9)

        bouncing_ball2 =
            BallFactory.bouncing_ball_with_a_reduce_rate(
                World::WORLD_WIDTH / 2, Ball::DEFAULT_RADIUS, Color::YELLOW, init_speed, 0.85)

        bouncing_ball3 =
            BallFactory.bouncing_ball_with_a_reduce_rate(
                1000, Ball::DEFAULT_RADIUS, Color::BLUE, init_speed, 0.8)


        [bouncing_ball1, bouncing_ball2, bouncing_ball3]
      end
    end

    def add_case2(showcase_scene)
      showcase_scene.add_case('Bouncing Ball swing left and right') do
        BallFactory.bouncing_ball_swing_left_and_right(
            100, Ball::DEFAULT_RADIUS, Color::PURPLE, 25, 10)
      end
    end

    def add_case3(showcase_scene)
      showcase_scene.add_case('Ball running in clockwise') do
        BallFactory.ball_running_in_clockwise(150, Ball::DEFAULT_RADIUS, Color::GREEN, 15)
      end
    end

    def add_case4(showcase_scene)
      showcase_scene.add_case('Passing energy between balls') do
        radius = 100
        balls = [
            BallFactory.ball(200, 200, radius, Color::RED),
            BallFactory.ball(200, 600, radius, Color::YELLOW),
            BallFactory.ball(640, 600, radius, Color::GREEN),
            BallFactory.ball(1080, 600, radius, Color::CYAN),
            BallFactory.ball(1080, 200, radius, Color::BLUE),
            BallFactory.ball(640, 200, radius, Color::PURPLE)
        ]
        balls.each(&:freeze!)

        balls[0]
            .add_behaviour(MoveDown)
            .add_behaviour(CollideWith.new(balls[1])
              .add_callback(Callback.clear_behaviours(balls[0]))
              .add_callback(Callback.active_spirit(balls[1])))
            .active!
        balls[1]
            .add_behaviour(MoveRight)
            .add_behaviour(CollideWith.new(balls[2])
              .add_callback(Callback.clear_behaviours(balls[1]))
              .add_callback(Callback.active_spirit(balls[2])))
        balls[2]
            .add_behaviour(MoveRight)
            .add_behaviour(CollideWith.new(balls[3])
              .add_callback(Callback.clear_behaviours(balls[2]))
              .add_callback(Callback.active_spirit(balls[3])))
        balls[3]
            .add_behaviour(MoveUp)
            .add_behaviour(CollideWith.new(balls[4])
              .add_callback(Callback.clear_behaviours(balls[3]))
              .add_callback(Callback.active_spirit(balls[4])))
        balls[4]
            .add_behaviour(MoveLeft)
            .add_behaviour(CollideWith.new(balls[5])
              .add_callback(Callback.clear_behaviours(balls[4]))
              .add_callback(Callback.active_spirit(balls[5])))
        balls[5].add_behaviour(MoveLeft)

        balls
      end
    end
  end
end