require 'spec_helper'
require_relative '../lesson3/passenger_carriage'

RSpec.describe PassengerCarriage do
  # subject {build(:passenger_carriage )}
  subject { described_class.new }

  describe 'free_space' do
    before do
      subject.take_space
      subject.take_space
      subject.rid_space
    end
    it 'return number of free seats' do
      expect(subject.free_space).to eq(49)
    end
  end
end
