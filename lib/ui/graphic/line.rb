class Line
  attr_reader :columns, :rows
  class << self
    @factory = {}

    def factory
      @factory
    end

    def create(radius, color)
      @factory["#{color}#{radius}"] || @factory["#{color}#{radius}"] = new(radius, color)
    end
  end

  def initialize(length, width, color)
    @columns = [length - (length & 1), 2].max
    @rows = [width - (width & 1), 1].max
    right_half = "\xff" * (@columns / 2)
    row = "#{right_half.reverse}#{right_half}"
    @blob = if @rows == 1
              row
            else
              lower_half = row * (@rows / 2)
              lower_half.reverse + lower_half
            end
    @blob.gsub!(/./) { |alpha| "#{color.to_ascii}#{alpha}" }
  end

  def to_blob
    @blob
  end
end