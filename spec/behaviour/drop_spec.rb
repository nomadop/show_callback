require 'rspec'
require 'module/activeable'
require 'behaviour/base'
require 'behaviour/drop'
require 'behaviour/callback'
require 'sprite/base'

describe 'Drop' do
  describe 'Spirit have drop behaviour' do
    before(:each) do
      allow(World.scene).to receive(:ground_y).and_return(380)
      @spirit = Spirit::Base.new(nil)
      @spirit.height = 10
      @spirit.add_behaviour(Drop.new.add_callback(Callback.disappear(@spirit)))
      @spirit.active_all_behaviours
    end

    it 'should go down before reach ground' do
      @spirit.center_y = 0

      @spirit.update

      expect(@spirit.center_y).to eq(Drop::DEFAULT_SPEED)
    end

    it 'should disappear after reach ground' do
      expect(World.scene).to receive(:remove_spirit).with(@spirit)

      @spirit.center_y = World.scene.ground_y

      @spirit.update
    end
  end
end