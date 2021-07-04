# frozen_string_literal: true

require_relative 'station'

class RemoteStation
  attr_reader :stations

  STATION_GUID = <<~HERE
    0 - exit to back
    1 - make station
    2 - check list of stations
    3 - check list of trains on station
  HERE
  def initialize
    @stations = []
  end

  def act_with_station
    loop do
      puts STATION_GUID
      choice = gets.to_i
      case choice
      when 0
        break
      when 1
        create_station
      when 2
        puts_every_station
      when 3
        station = choose_station
        puts_list_of_trains_on_station(station)
      end
    end
  end

  def puts_every_station
    @stations.each_with_index { |station, n| puts "#{n} - #{station.name}" }
  end

  private

  def create_station
    puts 'Enter a name'
    @stations.push(Station.new(gets.chomp))
    puts "You create #{@stations.last.name} station"
  rescue StandardError => e
    puts e.message
    puts "try again...\n"
    retry
  end

  def choose_station
    puts 'Enter a number of station'
    puts_every_station
    @stations[gets.to_i]
  end

  def puts_list_of_trains_on_station(station)
    number = 0
    station.each_train do |station|
      puts "#{number} - #{station}"
      number += 1
    end
  end
end
