module GoStep
  def go_up
    stop!
    add_behaviour(MoveUp.new(1))
  end
  
  def go_down
    stop!
    add_behaviour(MoveDown.new(1))
  end

  def go_right
    stop!
    add_behaviour(MoveRight.new(1))
  end

  def go_left
    stop!
    add_behaviour(MoveLeft.new(1))
  end

  def stop!
    clear_behaviours
  end
end