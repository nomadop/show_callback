module GoStraight
  def up
    stop!
    add_behaviour(MoveUp.new)
  end
  
  def down
    stop!
    add_behaviour(MoveDown.new)
  end

  def right
    stop!
    add_behaviour(MoveRight.new)
  end

  def left
    stop!
    add_behaviour(MoveLeft.new)
  end

  def stop!
    clear_behaviours
  end
end