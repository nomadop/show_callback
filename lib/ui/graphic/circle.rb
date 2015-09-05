class Circle
  attr_reader :columns, :rows
  class << self
    @@factory = {}

    def factory
      @@factory
    end

    def create(radius, color)
      @@factory["#{color}#{radius}"] || @@factory["#{color}#{radius}"] = new(radius, color)
    end
  end

  def initialize(radius, color)
    @columns = @rows = radius * 2
    lower_half = (0...radius).map do |y|
      x = Math.sqrt(radius**2 - y**2).round
      right_half = "#{"\xff" * x}#{"\x00" * (radius - x)}"
      "#{right_half.reverse}#{right_half}"
    end.join
    @blob = lower_half.reverse + lower_half
    @blob.gsub!(/./) { |alpha| "#{color.to_ascii}#{alpha}" }
  end

  def to_blob
    @blob
  end
end