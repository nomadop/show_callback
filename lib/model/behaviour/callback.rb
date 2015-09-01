class Callback
  class << self
    def disappear
      new { |behaviour| World.scene.remove_sprite(behaviour.sprite) }
    end

    def next_behaviour(_next_behaviour)
      new(_next_behaviour) do |behaviour, next_behaviour|
        sprite = behaviour.sprite
        sprite.add_behaviour(next_behaviour)
      end
    end

    def next_scene
      new { |behaviour| World.next_scene }
    end
  end

  def initialize(*args, &block)
    @args = args
    @proc = proc(&block)
  end

  def call(behaviour)
    @proc.call(behaviour, *@args)
  end

  def to_s
    @proc.to_s
  end
end