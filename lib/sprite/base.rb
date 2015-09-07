module Spirit
  class Base
    include Activable

    attr_accessor :center_x
    attr_accessor :center_y
    attr_accessor :height
    attr_accessor :width

    attr_accessor :image

    def initialize(image)
      @image = image
      @behaviours = []
      @active = true
    end

    def update
      @behaviours.each do |behaviour|
        next if behaviour.freeze?

        behaviour.update
        behaviour.callback if behaviour.finish?
      end

      @behaviours.delete_if { |behaviour| behaviour.active? && behaviour.finish? }
      active_all_behaviours
    end

    def active_all_behaviours
      @behaviours.each(&:active!)
    end

    def add_behaviour(*args)
      if args[0].is_a?(Class)
        behaviour = args[0].new(*args[1...-1])
      else
        behaviour = args[0]
      end
      behaviour.attach_spirit(self)
      yield(behaviour) if block_given?
      @behaviours << behaviour
      self
    end

    def remove_behaviour(behaviour)
      @behaviours.delete(behaviour)
      self
    end

    def clear_behaviours
      @behaviours.clear
    end

    def add_behaviour_chain(arguments = {}, &block)
      Behaviour::Chain.new(self, arguments, &block)
      self
    end

    def draw
      @image.draw(upper_left.x, upper_left.y, 0)
    end

    def center
      Point.new(center_x, center_y)
    end

    def upper_left
      Point.new(left_x, top_y)
    end

    def half_height
      height / 2
    end

    def half_width
      width / 2
    end

    def top_y
      center_y - half_height
    end

    def bottom_y
      center_y + half_height
    end

    def left_x
      center_x - half_width
    end

    def right_x
      center_x + half_width
    end

    def collide?(other)
      (self.center_x - other.center_x).abs <= self.half_width + other.half_width &&
      (self.center_y - other.center_y).abs <= self.half_height + other.half_height
    end
  end
end