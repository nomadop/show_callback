module BallFactory
  module_function

  def ball(center_x, center_y, radius, color)
    Ball.new(center_x, center_y, radius, color)
  end

  def drop(min_radius: 2, max_radius: 5, initial_y: 0)
    center_x = Gosu.random(0, World::WORLD_WIDTH)
    radius = Gosu.random(min_radius, max_radius)
    ball(center_x, initial_y, radius, Gosu::Color.rgb(0, 100, 200))
  end

  def sun(center_x: -150, center_y: -100, radius: 150)
    ball(center_x, center_y, radius, Gosu::Color::YELLOW)
  end

  def bouncing_ball_swing_left_and_right(center_x, center_y, radius, color, bouncing_speed, swing_speed)
    bouncing_ball = ball(center_x, center_y, radius, color)
    bouncing_ball.add_behaviour_chain do |bouncing_chain|
      bouncing_chain
          .add_behaviour { Bounce.new(bouncing_speed) }
          .loop!
    end
    bouncing_ball.add_behaviour_chain do |swing_chain|
      swing_chain
          .add_behaviour { MoveRight.new(World::WORLD_WIDTH, swing_speed) }
          .add_behaviour { MoveLeft.new(World::WORLD_WIDTH, swing_speed) }
          .loop!
    end
  end

  def bouncing_ball_with_a_reduce_rate(center_x, center_y, radius, color, speed, reduce_rate)
    bouncing_ball = ball(center_x, center_y, radius, color)
    bouncing_ball.add_behaviour_chain do |bouncing_chain|
      bouncing_chain
          .add_behaviour do
            Bounce.new(speed) do |bounce|
              speed *= reduce_rate
              bounce.add_callback(freeze_spirit(bouncing_ball)) if speed < 1
            end
          end.loop!
    end
  end

  def ball_running_in_clockwise(padding, radius, color, speed)
    ball = ball(padding, padding, radius, color)
    ball.add_behaviour_chain do |movement_chain|
      movement_chain
          .add_behaviour { MoveDown.new(World::WORLD_HEIGHT - padding * 2, speed) }
          .add_behaviour { Wait.new(0.5) }
          .add_behaviour { MoveRight.new(World::WORLD_WIDTH - padding * 2, speed) }
          .add_behaviour { Wait.new(0.5) }
          .add_behaviour { MoveUp.new(World::WORLD_HEIGHT - padding * 2, speed) }
          .add_behaviour { Wait.new(0.5) }
          .add_behaviour { MoveLeft.new(World::WORLD_WIDTH - padding * 2, speed) }
          .add_behaviour { Wait.new(0.5) }
          .loop!
    end
  end

end