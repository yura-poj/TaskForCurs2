require 'spec_helper'
require_relative '../lesson3/train'

RSpec.describe Train do
  let(:train) { Train.new('00001') }
  let(:trains) { [Train.new('00001')] }
  describe '.find' do
    context 'when train with that number exists' do
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

    it 'return count of train instances' do
      expect(Train.counter).to eq trains.size
    end
  end

  describe '.attr_accessor_with_history' do
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

  describe 'valid?' do
    let(:wrong_train) { Train.new('12345') }
    before {wrong_train.number = '132'}
    context 'Data is all right' do
      it 'return true' do
        expect(train.valid?).to eq(true)
      end
    end
    context 'Data is wrong' do
      it 'return false' do
        expect(wrong_train.valid?).to eq(false)
      end
    end
  end
end
