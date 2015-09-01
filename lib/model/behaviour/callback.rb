class Callback
  class << self
    def disappear(_sprite)
      new(_sprite) { |sprite| World.scene.remove_sprite(sprite) }
    end

    def next_behaviour(_sprite, _next_behaviour)
      new(_sprite, _next_behaviour) do |sprite, next_behaviour|
        next_behaviour = next_behaviour.build if next_behaviour.is_a?(Behaviour::Builder)
        sprite.add_behaviour(next_behaviour)
      end
    end

    def next_scene
      new { World.next_scene }
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