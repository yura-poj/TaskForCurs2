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
    let(:trains) { build_list(:train, 2) }

    it 'return count of trian instances' do
      expect(described_class.instances).to eq trains.size
    end
  end
end
