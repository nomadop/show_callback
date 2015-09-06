require 'rspec'
require 'module/activeable'
require 'sprite/base'
require 'behaviour/base'
require 'behaviour/simple_movement'
require 'behaviour/move_down'

describe 'Spirit' do

  describe 'with behaviour move down' do

    before(:each) do
      @spirit = Spirit::Base.new(nil)
      @spirit.height = 100

      @spirit.add_behaviour(MoveDown)
    end

    it 'should go down before reach bottom' do
      @spirit.center_y = 0

      @spirit.active_all_behaviours
      @spirit.update

      expect(@spirit.center_y).to eq(SimpleMovement::DEFAULT_SPEED)
    end

    it 'should stop after reach bottom' do
      @spirit.center_y = World::WORLD_HEIGHT

      @spirit.active_all_behaviours
      @spirit.update

      expect(@spirit.bottom_y).to eq(World::WORLD_HEIGHT)
    end
  end

end