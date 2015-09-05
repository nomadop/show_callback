class BallFactory
  class << self
    def ball(center_x, center_y, radius, color)
      Ball.new(center_x, center_y, radius, color)
    end

    def rain(min_radius: 2, max_radius: 5, initial_y: 0)
      center_x = 0.upto(World::WORLD_WIDTH).to_a.sample
      radius = min_radius.upto(max_radius).to_a.sample
      ball(center_x, initial_y, radius, Color.new(0, 100, 200))
    end

    def sun(center_x: -150, center_y: -100, radius: 150)
      ball(center_x, center_y, radius, Color::ORANGE)
    end

    def bouncing_ball_with_a_reduce_rate(center_x, radius, color, init_speed, reduce_rate)
      center_y = World::WORLD_HEIGHT - radius
      bouncing_ball = ball(center_x, center_y, radius, color)
      bouncing_ball.tap do
        bouncing_chain = Behaviour::Chain.new(bouncing_ball)
        bouncing_chain
            .set_argument(:init_speed, init_speed)
            .set_argument(:reduce_rate, reduce_rate)
            .add_behaviour do |chain|
              init_speed = chain.get_argument(:init_speed) * chain.get_argument(:reduce_rate)
              chain.set_argument(:init_speed, init_speed)
              Bounce.new(init_speed)
            end.loop!
      end
    end

    def bouncing_ball_swing_left_and_right(center_x, radius, color, bouncing_speed, swing_speed)
      center_y = World::WORLD_HEIGHT - radius
      bouncing_ball = ball(center_x, center_y, radius, color)
      bouncing_ball.tap do
        bounce_chain = Behaviour::Chain.new(bouncing_ball)
        bounce_chain
            .add_behaviour { Bounce.new(bouncing_speed) }
            .loop!

        swing_chain = Behaviour::Chain.new(bouncing_ball)
        swing_chain
            .add_behaviour { MoveRight.new(World::WORLD_WIDTH, swing_speed) }
            .add_behaviour { MoveLeft.new(World::WORLD_WIDTH, swing_speed) }
            .loop!
      end
    end

    def ball_running_in_movement_queue(center_x, center_y, radius, color, movements, distance, speed)
      ball = ball(center_x, center_y, radius, color)
      ball.tap do
        movement_chain = Behaviour::Chain.new(ball)
        movements.each do |movement|
          movement_chain
              .add_behaviour { movement.new(distance, speed) }
              .add_behaviour { Wait.new(0.1) }
        end
        movement_chain.end!
      end
    end

    def ball_running_in_clockwise(padding, radius, color, speed)
      ball = ball(padding, padding, radius, color)
      ball.tap do
        movement_chain = Behaviour::Chain.new(ball)
        movement_chain
            .add_behaviour { MoveDown.new(World::WORLD_HEIGHT - padding * 2, speed) }
            .add_behaviour { Wait.new(0.5) }
            .add_behaviour { MoveRight.new(World::WORLD_WIDTH - padding * 2, speed * 1.6) }
            .add_behaviour { Wait.new(0.5) }
            .add_behaviour { MoveUp.new(World::WORLD_HEIGHT - padding * 2, speed) }
            .add_behaviour { Wait.new(0.5) }
            .add_behaviour { MoveLeft.new(World::WORLD_WIDTH - padding * 2, speed * 1.6) }
            .add_behaviour { Wait.new(0.5) }
            .loop!
      end
    end
  end
end