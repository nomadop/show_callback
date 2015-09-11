module GoStep
  def go_up
    add_behaviour(MoveUp.new(1))
  end
  
  def go_down
    add_behaviour(MoveDown.new(1))
  end

  def go_right
    add_behaviour(MoveRight.new(1))
  end

  def go_left
    add_behaviour(MoveLeft.new(1))
  end
end