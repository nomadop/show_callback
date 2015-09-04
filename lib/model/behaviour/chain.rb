class Chain
  attr_reader :behaviour_builders

  def initialize(spirit)
    @spirit = spirit
    @behaviour_builders = []
    @args = {}
  end

  def set_argument(key, value)
    @args[key] = value
  end

  def get_argument(key)
    @args.fetch(key)
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
      behaviour.add_callback(Callback.next_behaviour(@spirit, behaviour_builder))
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
    attach_spirit
  end

  def end!
    attach_spirit
  end

  def attach_spirit
    @spirit.add_behaviour(first_behaviour)
  end
end