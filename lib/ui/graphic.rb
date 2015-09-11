module Graphic
  BASE = Struct.new(:columns, :rows)
  CIRCLE = BASE.new
  LINE = BASE.new
  DEFAULT_LENGTH = World::WORLD_WIDTH
  DEFAULT_WEIGHT = 10
  DEFAULT_RADIUS = 100

  def CIRCLE.to_blob
    @blob ||=
        begin
          self.columns = self.rows = DEFAULT_RADIUS * 2
          lower_half = (0...DEFAULT_RADIUS).map do |y|
            x = Math.sqrt(DEFAULT_RADIUS**2 - y**2).round
            right_half = "#{"\xff" * x}#{"\x00" * (DEFAULT_RADIUS - x)}"
            "#{right_half.reverse}#{right_half}"
          end.join
          blob = lower_half.reverse + lower_half
          blob.gsub!(/./) { |alpha| "\xff\xff\xff#{alpha}" }
        end
  end

  def LINE.to_blob
    @blob ||=
        begin
          self.columns = DEFAULT_LENGTH
          self.rows = DEFAULT_WEIGHT
          right_half = "\xff" * (columns / 2)
          row = "#{right_half.reverse}#{right_half}"
          lower_half = row * (rows / 2)
          blob = lower_half.reverse + lower_half
          blob.gsub!(/./) { |alpha| "\xff\xff\xff#{alpha}" }
        end
  end
end