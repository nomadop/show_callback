module Spirit
  class Base
    attr_accessor :center_x
    attr_accessor :center_y
    attr_accessor :height
    attr_accessor :width

    attr_accessor :image
    attr_accessor :behaviours

    def initialize(image)
      @image = image
      @behaviours = []
    end

    def update
      @behaviours.each do |behaviour|
        next if behaviour.inactive?

        behaviour.update
        if behaviour.finish?
          behaviour.callback
          behaviour.finish!
        end
      end

      @behaviours.delete_if { |behaviour| behaviour.active? && behaviour.finish? }
      @behaviours.select(&:inactive?).each(&:active!)
      true
    end

    def add_behaviour(behaviour)
      behaviour.attach_spirit(self)
      @behaviours << behaviour
      self
    end

    def remove_behaviour(behaviour)
      @behaviours.delete(behaviour)
      self
    end

    def draw
      @image.draw(upper_left.x, upper_left.y, 0)
    end

    def center
      Point.new(center_x, center_y)
    end

    def upper_left
      Point.new(center_x - width / 2, center_y - height / 2)
    end

    def half_height
      height / 2
    end

    def half_width
      width / 2
    end
  end
end