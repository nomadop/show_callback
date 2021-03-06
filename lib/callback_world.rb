class CallbackWorld
  class << self
    def initialize
      World.new(caption: 'Behaviours Callback Demo')

      showcase_scene = ShowcaseScene.new
      rain_scene = RainScene.new(7000, 7)

      World
          .add_scene(rain_scene)
          .add_scene(showcase_scene)

      add_case1(showcase_scene)
      add_case2(showcase_scene)
      add_case3(showcase_scene)
    end

    def add_case1(showcase_scene)
      showcase_scene.add_case('Bouncing ball swing left and right') do
        BallFactory.bouncing_ball_swing_left_and_right(
            100,
            World::WORLD_HEIGHT - Ball::DEFAULT_RADIUS,
            Ball::DEFAULT_RADIUS,
            Gosu::Color.rgb(255, 0, 255),
            25,
            10
        )
      end
    end

    def add_case2(showcase_scene)
      showcase_scene.add_case('Bouncing balls with reduce rate') do
        init_speed = 35
        center_y = World::WORLD_HEIGHT - Ball::DEFAULT_RADIUS
        bouncing_ball1 = BallFactory.bouncing_ball_with_a_reduce_rate(
                             280,
                             center_y,
                             Ball::DEFAULT_RADIUS,
                             Gosu::Color::RED,
                             init_speed,
                             0.9
                         )

        bouncing_ball2 = BallFactory.bouncing_ball_with_a_reduce_rate(
                             640,
                             center_y,
                             Ball::DEFAULT_RADIUS,
                             Gosu::Color::YELLOW,
                             init_speed,
                             0.8
                         )

        bouncing_ball3 = BallFactory.bouncing_ball_with_a_reduce_rate(
                             1000,
                             center_y,
                             Ball::DEFAULT_RADIUS,
                             Gosu::Color::BLUE,
                             init_speed,
                             0.7
                         )


        [bouncing_ball1, bouncing_ball2, bouncing_ball3]
      end
    end

    def add_case3(showcase_scene)
      showcase_scene.add_case('Collision between balls') do
        radius = 120
        balls = [
            BallFactory.ball(200, 200, radius, Gosu::Color::RED),
            BallFactory.ball(200, 600, radius, Gosu::Color::YELLOW),
            BallFactory.ball(640, 600, radius, Gosu::Color::GREEN),
            BallFactory.ball(1080, 600, radius, Gosu::Color::CYAN),
            BallFactory.ball(1080, 200, radius, Gosu::Color::BLUE),
            BallFactory.ball(640, 200, radius, Gosu::Color.rgb(255, 0, 255))
        ]
        balls.each(&:freeze!)

        initialize_balls_in_case3(balls[0], balls[1], MoveDown)
        initialize_balls_in_case3(balls[1], balls[2], MoveRight)
        initialize_balls_in_case3(balls[2], balls[3], MoveRight)
        initialize_balls_in_case3(balls[3], balls[4], MoveUp)
        initialize_balls_in_case3(balls[4], balls[5], MoveLeft)
        initialize_balls_in_case3(balls[5], balls[0], MoveLeft)
        balls[0].active!

        balls
      end
    end

    def initialize_balls_in_case3(ball, next_ball, movement)
      ball.add_behaviour(movement)
          .add_behaviour(CollideWith.new(next_ball)) do |collide|
            collide
              .add_callback(active_spirit(next_ball))
              .add_callback(freeze_spirit(ball))
          end
    end
  end
end