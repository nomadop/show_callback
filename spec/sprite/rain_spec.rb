require 'rspec'
require 'module/activeable'
require 'sprite/base'
require 'sprite/ball'
require 'sprite/rain'
require 'behaviour/base'
require 'behaviour/drop'
require 'behaviour/callback'

describe 'Rain' do

  it 'should drop' do
    initial_y = 0
    rain = Rain.new(center_y: initial_y)

    rain.active_all_behaviours
    rain.update

    expect(rain.center_y).to eq(initial_y + Drop::DEFAULT_SPEED)
  end

  it 'should disappear when reach ground' do
    rain = Rain.new
    rain.center_y = 380 - rain.half_height
    allow(World.scene).to receive(:remove_spirit).with(rain)

    rain.active_all_behaviours
    rain.update

    expect(World.scene).to have_received(:remove_spirit).with(rain)
  end
end