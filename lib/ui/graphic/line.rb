class Line
  attr_reader :columns, :rows
  @factory = {}
  class << self
    def factory
      @factory
    end

    def create(length, width, color)
      @factory["#{color}:#{length}*#{width}"] ||
      @factory["#{color}:#{length}*#{width}"] = new(length, width, color)
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