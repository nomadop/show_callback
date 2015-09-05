module GoStraight
  def go_up
    stop!
    add_behaviour(MoveUp)
  end
  
  def go_down
    stop!
    add_behaviour(MoveDown)
  end

  def go_right
    stop!
    add_behaviour(MoveRight)
  end

  def go_left
    stop!
    add_behaviour(MoveLeft)
  end

  def stop!
    clear_behaviours
  end
end