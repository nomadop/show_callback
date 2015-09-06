class Callback
  class << self

    def disappear(spirit)
      lambda { World.scene.remove_spirit(spirit) }
    end

    def next_behaviour(spirit, next_behaviour)
      lambda do
        next_behaviour = next_behaviour.build if next_behaviour.is_a?(Behaviour::Builder)
        spirit.add_behaviour(next_behaviour) unless next_behaviour.nil?
      end
    end

    def next_scene
      lambda { World.next_scene }
    end

    def active_spirit(spirit)
      lambda { spirit.active! }
    end

    def freeze_spirit(spirit)
      lambda { spirit.freeze! }
    end

  end
end