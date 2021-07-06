require 'spec_helper'
require_relative '../lesson3/train'

RSpec.describe Train do
  describe '.find' do
    context 'when train with that number exists' do
      let(:train) { Train.new('00001') }
      it 'reutn train' do
        expect(Train.find(train.number)).to eq(train)
      end
    end

    context 'when train with that number is not exist' do
      it 'return nil' do
        expect(Train.find('11122')).to be_nil
      end
    end
  end

  describe '.instances' do
    let(:trains) { [Train.new('00001')] }

    it 'return count of train instances' do
      expect(Train.counter).to eq trains.size
    end
  end

  describe '.attr_accessor_with_history' do
    let(:train) { Train.new('00001') }
    before do
      train.speed = 2
      train.speed = 3
    end
    it 'get instance variable' do
      expect(train.speed).to eq(3)
    end
    it 'get variable history of changes' do
      expect(train.speed_history).to eq [2, 3]
    end
  end
end
