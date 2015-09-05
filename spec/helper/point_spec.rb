require 'rspec'
require 'helper/point'

describe 'Point' do

  describe 'Calculate distance between two point' do

    it 'should return 10 between (0, 0), (10, 0)' do
      point1 = Point.new(0, 0)
      point2 = Point.new(10, 0)

      expect(point1.distance_to(point2)).to eq(10)
    end

    it 'should return 5 between (0, 0), (-3, -4)' do
      point1 = Point.new(0, 0)
      point2 = Point.new(-3, -4)

      expect(point1.distance_to(point2)).to eq(5)
    end

  end
end