require 'rspec'
require 'helper/point'

describe 'Point' do

  describe 'Calculate distance between two point' do

    it 'should return 10 between (0, 0), (10, 0)' do
      point1 = Point.new(0, 0)
      point2 = Point.new(10, 0)

      expect(point1.distance_to(point2)).to eq(10)
    end

    it 'should return 5 between (-3, -4), (0, 0)' do
      point1 = Point.new(-3, -4)
      point2 = Point.new(0, 0)

      expect(point1.distance_to(point2)).to eq(5)
    end

  end

  describe 'Calculate distance from point to line' do

    it 'should return 2.4 when point is (0, 0) and line is [(0, 3), (4, 0)]' do
      point = Point.new(0, 0)
      line = [Point.new(0, 3), Point.new(4, 0)]

      expect(Point.pedal(line[0], line[1], point)).to eq(2.4)
    end

    it "should return #{Math.sqrt(2)} when point is (2, 0) and line is [(0, 0), (2, 2)]" do
      point = Point.new(2, 0)
      line = [Point.new(0, 0), Point.new(2, 2)]

      expect(Point.pedal(line[0], line[1], point)).to be_within(0.0000000001).of(Math.sqrt(2))
    end

    it "should return #{Math.sqrt(3)} when point is (0, 2) and line is [(0, 0), (#{2 * Math.sqrt(3)}, 2)]" do
      point = Point.new(0, 2)
      line = [Point.new(0, 0), Point.new(2 * Math.sqrt(3), 2)]

      expect(Point.pedal(line[0], line[1], point)).to be_within(0.0000000001).of(Math.sqrt(3))
    end

  end
end