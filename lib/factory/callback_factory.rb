module CallbackFactory
  module_function

  def disappear(spirit)
    -> { World.scene.remove_spirit(spirit) }
  end

  def next_behaviour(spirit, next_behaviour)
    lambda do
      next_behaviour = next_behaviour.build if next_behaviour.is_a?(Behaviour::Builder)
      spirit.add_behaviour(next_behaviour) unless next_behaviour.nil?
    end
  end

  def next_behaviour_chain(spirit, &block)
    -> { spirit.add_behaviour_chain(&block) }
  end

  def active_spirit(spirit)
    -> { spirit.active! }
  end

  def freeze_spirit(spirit)
    -> { spirit.freeze! }
  end

end