class CallbackWorld
  class << self
    def initialize
      World.new(caption: "Behaviours Callback Demo")

      rain_scene = RainScene.new(2000, 5)
      showcase_scene = ShowcaseScene.new

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
      showcase_scene.add_case('Bouncing Balls') do
        bouncing_ball1 =
            BallFactory.bouncing_ball_with_a_reduce_rate(
                World::WORLD_WIDTH / 2, Ball::DEFAULT_RADIUS, Color::RED, 40, 0.9)

        bouncing_ball2 =
            BallFactory.bouncing_ball_swing_left_and_right(
                200, Ball::DEFAULT_RADIUS, Color::BLUE, 25, 10)

        [bouncing_ball1, bouncing_ball2]
      end
    end

    def add_case2(showcase_scene)
      showcase_scene.add_case('Ball running in movements queue') do
        movements = [
            MoveDown, MoveRight, MoveDown, MoveLeft, MoveDown,
            MoveRight, MoveRight, MoveRight, MoveUp, MoveLeft,
            MoveUp, MoveRight, MoveUp, MoveRight, MoveDown,
            MoveRight, MoveDown, MoveLeft, MoveDown, MoveRight
        ]

        BallFactory.ball_running_in_movement_queue(
            100, 100, Ball::DEFAULT_RADIUS, Color::PURPLE, movements, 200, 10)
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

        speed = 10
        balls[0]
            .add_behaviour(MoveTo.new(200, 400, speed)
            .add_callback(Callback.active_spirit(balls[1])))
            .active!
        balls[1]
            .add_behaviour(MoveTo.new(440, 600, speed)
            .add_callback(Callback.active_spirit(balls[2])))
        balls[2]
            .add_behaviour(MoveTo.new(880, 600, speed)
            .add_callback(Callback.active_spirit(balls[3])))
        balls[3]
            .add_behaviour(MoveTo.new(1080, 400, speed)
            .add_callback(Callback.active_spirit(balls[4])))
        balls[4]
            .add_behaviour(MoveTo.new(840, 200, speed)
            .add_callback(Callback.active_spirit(balls[5])))
        balls[5].add_behaviour(MoveTo.new(400, 200, speed))

        balls
      end
    end
  end
end