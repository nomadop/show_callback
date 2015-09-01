class Chain
  attr_reader :behaviours

  def initialize(sprite)
    @sprite = sprite
    @behaviours = []
  end

  def add_behaviour(behaviour)
    link_behaviour(behaviour)

    @behaviours << behaviour
    self
  end

  def link_behaviour(behaviour)
    last_behaviour = @behaviours.last
    last_behaviour.add_callback(Callback.next_behaviour(@sprite, behaviour)) unless last_behaviour.nil?
  end

  def first_behaviour
    @behaviours.first
  end

  def loop!
    link_behaviour(first_behaviour)
    attach_sprite
  end

  def end!
    attach_sprite
  end

  def attach_sprite
    @sprite.add_behaviour(first_behaviour)
  end
end