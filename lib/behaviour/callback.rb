class Callback
  class << self
    def disappear(_spirit)
      new(_spirit) { |spirit| World.scene.remove_spirit(spirit) }
    end

    def next_behaviour(_spirit, _next_behaviour)
      new(_spirit, _next_behaviour) do |spirit, next_behaviour|
        next_behaviour = next_behaviour.build if next_behaviour.is_a?(Behaviour::Builder)
        spirit.add_behaviour(next_behaviour)
      end
    end

    def next_scene
      new { World.next_scene }
    end

    def active_spirit(_spirit)
      new(_spirit) { |spirit| spirit.active! }
    end
  end

  def initialize(*args, &block)
    @args = args
    @proc = proc(&block)
  end

  def call
    @proc.call(*@args)
  end

  def to_s
    @proc.to_s
  end
end