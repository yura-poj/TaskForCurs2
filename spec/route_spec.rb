require 'spec_helper'
require_relative '../lesson3/route'
require 'byebug'
RSpec.describe Route do
  let(:stations) { build_list(:station, 3) }
  subject do
    described_class.new(start_station: stations.first, finish_station: stations.last)
  end

  describe '#delete_station' do
    before { subject.add_station(station: stations[1]) }

    it 'delete station from station list' do
      subject.delete_station(obj: subject.stations_list[1])
      expect(subject.stations_list).to eq([stations.first, stations.last])
    end
  end
end
