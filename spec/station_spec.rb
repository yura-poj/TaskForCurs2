require 'spec_helper'
require_relative '../lesson3/station'
require_relative '../lesson3/train'
require 'byebug'

RSpec.describe Station do
  subject { described_class.new('A') }
  let(:trains) { [Train.new(12_345), Train.new(12_341)] }

  describe 'train_leave' do
    before do
      subject.add_train(trains.first)
      subject.add_train(trains.last)
      subject.train_leave
    end

    it 'Remove first train from list' do
      expect(subject.trains_list).to eq([trains.last])
    end
  end

  describe 'return_trains_by_type' do
    before do
      subject.add_train(trains.first)
      subject.add_train(trains.last)
    end
    it 'return list of trains on type' do
      expect(subject.return_trains_by_type(nil)).to eq(trains)
    end
  end
end
