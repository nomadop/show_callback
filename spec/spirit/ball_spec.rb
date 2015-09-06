require 'rspec'
require 'module/activeable'
require 'sprite/base'
require 'sprite/ball'

describe 'Ball' do
  before(:each) do
    @ball = Ball.new(0, 0, Ball::DEFAULT_RADIUS, nil)
  end

  it 'should be a Spirit::Base' do
    expect(@ball).to be_a(Spirit::Base)
  end

  it 'should return 100 when receive height' do
    expect(@ball.height).to eq(100)
  end

  it 'should return 100 when receive width' do
    expect(@ball.width).to eq(100)
  end
end