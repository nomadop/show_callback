module Spirit
  class Base
    include Activable

    attr_accessor :center_x
    attr_accessor :center_y
    attr_accessor :z_index
    attr_accessor :height
    attr_accessor :width
    attr_accessor :angle

    attr_accessor :image

    def initialize(image)
      @image = image
      @behaviours = []
      @active = true
      @z_index = 0
      @angle = 0.0
    end

    def update
      @behaviours.each do |behaviour|
        next if behaviour.freeze?

        behaviour.update
        behaviour.callback if behaviour.finish?
      end

      @behaviours.delete_if { |behaviour| behaviour.active? && behaviour.finish? && !behaviour.persistent? }
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

    def add_behaviour_chain(&block)
      chain = Behaviour::Chain.new(self, &block)
      fail 'Behaviour chain is not closed' unless chain.close?
      self
    end

    def draw
      @image.draw_rot(center_x, center_y, @z_index, @angle, 0.5, 0.5, scale_x, scale_y, @color)
      draw_box if $DEBUG_MODE
    end

    def draw_box
      line = World.line_image
      line.draw_rot(upper_left.x, upper_left.y, @z_index, 90.0, 0.0, 0.0, height.to_f / Graphic::DEFAULT_LENGTH, 1.0 / Graphic::DEFAULT_WEIGHT, Gosu::Color::GREEN)
      line.draw_rot(upper_right.x, upper_right.y, @z_index, 90.0, 0.0, 0.0, height.to_f / Graphic::DEFAULT_LENGTH, 1.0 / Graphic::DEFAULT_WEIGHT, Gosu::Color::GREEN)
      line.draw_rot(upper_left.x, upper_left.y, @z_index, 0.0, 0.0, 0.0, width.to_f / Graphic::DEFAULT_LENGTH, 1.0 / Graphic::DEFAULT_WEIGHT, Gosu::Color::GREEN)
      line.draw_rot(lower_left.x, lower_left.y, @z_index, 0.0, 0.0, 0.0, width.to_f / Graphic::DEFAULT_LENGTH, 1.0 / Graphic::DEFAULT_WEIGHT, Gosu::Color::GREEN)
    end

    def angle=(other)
      @angle = other.modulo(360.0)
    end

    def radians
      (@angle / 180) * Math::PI
    end

    def scale_y
      1
    end

    def scale_x
      1
    end

    def center
      Point.new(center_x, center_y)
    end

    def upper_left
      Point.new(left_x, top_y)
    end

    def lower_left
      Point.new(left_x, bottom_y)
    end

    def upper_right
      Point.new(right_x, top_y)
    end

    def lower_right
      Point.new(right_x, bottom_y)
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