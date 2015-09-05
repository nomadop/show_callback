module GoStraight
  def up
    stop!
    add_behaviour(MoveUp)
  end
  
  def down
    stop!
    add_behaviour(MoveDown)
  end

  def right
    stop!
    add_behaviour(MoveRight)
  end

  def left
    stop!
    add_behaviour(MoveLeft)
  end

  def stop!
    clear_behaviours
  end
end