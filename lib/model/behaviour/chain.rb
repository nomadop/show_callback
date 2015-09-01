class Chain
  attr_reader :behaviour_builders

  def initialize(sprite)
    @sprite = sprite
    @behaviour_builders = []
  end

  def add_behaviour(&block)
    behaviour_builder = Behaviour::Builder.new(&block)
    link_behaviour(behaviour_builder)

    @behaviour_builders << behaviour_builder
    self
  end

  def link_behaviour(behaviour_builder)
    return if @behaviour_builders.empty?

    last_builder = @behaviour_builders.last
    last_builder.after_build do |behaviour|
      behaviour.add_callback(Callback.next_behaviour(@sprite, behaviour_builder))
    end
  end

  def first_behaviour
    first_builder.build
  end

  def first_builder
    @behaviour_builders.first
  end

  def loop!
    link_behaviour(first_builder)
    attach_sprite
  end

  def end!
    attach_sprite
  end

  def attach_sprite
    @sprite.add_behaviour(first_behaviour)
  end
end