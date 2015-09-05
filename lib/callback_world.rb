class CallbackWorld
  class << self
    def initialize
      World.new(caption: "Behaviours Callback Demo")

      rain_scene = RainScene.new(1000, 3)
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
        bouncing_ball1 = Ball.new(World::WORLD_WIDTH / 2, World::WORLD_HEIGHT - 50, Ball::DEFAULT_RADIUS, Color::RED)
        behaviour_chain = Chain.new(bouncing_ball1)
        behaviour_chain
            .set_argument(:init_speed, -40)
            .set_argument(:bouncing_rate, 0.9)
            .add_behaviour do |chain|
          init_speed = chain.get_argument(:init_speed) * chain.get_argument(:bouncing_rate)
          chain.set_argument(:init_speed, init_speed)
          Bounce.new(init_speed)
        end.loop!

        bouncing_ball2 = Ball.new(200, World::WORLD_HEIGHT - Ball::DEFAULT_RADIUS, Ball::DEFAULT_RADIUS, Color::BLUE)
        init_bounce_speed = -25
        bounce_chain = Chain.new(bouncing_ball2)
        bounce_chain
            .add_behaviour { Bounce.new(init_bounce_speed) }
            .loop!

        swing_speed = 10
        swing_chain = Chain.new(bouncing_ball2)
        swing_chain
            .add_behaviour { MoveRight.new(World::WORLD_WIDTH, swing_speed) }
            .add_behaviour { MoveLeft.new(World::WORLD_WIDTH, swing_speed) }
            .loop!

        [bouncing_ball1, bouncing_ball2]
      end
    end

    def add_case2(showcase_scene)
      showcase_scene.add_case('Ball running in a path') do
        spirit = Ball.new(70, 100, Ball::DEFAULT_RADIUS, Color::PURPLE)
        distance, speed = 200, 10
        move_up = proc { MoveUp.new(distance, speed) }
        move_down = proc { MoveDown.new(distance, speed) }
        move_left = proc { MoveLeft.new(distance, speed) }
        move_right = proc { MoveRight.new(distance, speed) }

        movements = [
            move_down, move_right, move_down, move_left, move_down, move_right, move_right, move_right,
            move_up, move_left, move_up, move_right, move_up, move_right, move_down, move_right,
            move_down, move_left, move_down, move_right
        ]

        behaviour_chain = Chain.new(spirit)
        movements.each do |movement|
          behaviour_chain
              .add_behaviour(&movement)
              .add_behaviour { Wait.new(0.1) }
        end
        behaviour_chain.end!
      end
    end

    def add_case3(showcase_scene)
      showcase_scene.add_case('Ball running in clockwise') do
        padding = 200
        spirit = Ball.new(padding, padding, Ball::DEFAULT_RADIUS, Color::GREEN)
        behaviour_chain = Chain.new(spirit)
        behaviour_chain
            .add_behaviour { MoveDown.new(World::WORLD_HEIGHT - padding * 2, 10) }
            .add_behaviour { Wait.new(0.5) }
            .add_behaviour { MoveRight.new(World::WORLD_WIDTH - padding * 2, 15) }
            .add_behaviour { Wait.new(0.5) }
            .add_behaviour { MoveUp.new(World::WORLD_HEIGHT - padding * 2, 10) }
            .add_behaviour { Wait.new(0.5) }
            .add_behaviour { MoveLeft.new(World::WORLD_WIDTH - padding * 2, 15) }
            .add_behaviour { Wait.new(0.5) }
            .loop!
      end
    end

    def add_case4(showcase_scene)
      showcase_scene.add_case('Passing energy between balls') do
        radius = 100
        balls = [
            Ball.new(200, 200, radius, Color::RED),
            Ball.new(200, 600, radius, Color::YELLOW),
            Ball.new(640, 600, radius, Color::GREEN),
            Ball.new(1080, 600, radius, Color::CYAN),
            Ball.new(1080, 200, radius, Color::BLUE),
            Ball.new(640, 200, radius, Color::PURPLE)
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