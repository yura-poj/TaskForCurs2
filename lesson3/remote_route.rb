# frozen_string_literal: true

require_relative 'route'

class RemoteRoute
  attr_reader :routes
  ROUTE_GUID = '0 - back 1 - create 2 - act with stations'

  def initialize(remote_station)
    @routes = []
    @remote_station = remote_station
  end

  def act_with_route
    loop do
      puts ROUTE_GUID
      choice = gets.to_i
      case choice
      when 0
        break
      when 1
        create_route
      when 2
        act_with_station_from_route
      end
    end
  end

  def puts_every_route
    @routes.each_with_index { |route, n| puts "#{n} - #{route}" }
  end

  def choose_route
    puts 'Enter number of route'
    puts_every_route
    @routes[gets.to_i]
  end

  private

  def create_route
    puts 'Enter number of first and last station'
    @remote_station.puts_every_station
    begin
      @routes.push(Route.new(start_station: @remote_station.stations[gets.to_i], finish_station: @remote_station.stations[gets.to_i]))
      puts "You create #{@routes.last} station"
    rescue StandardError => e
      puts e.message
    end
  end

  def act_with_station_from_route
    route = choose_route
    loop do
      puts "0 - exit to back \n1 - add station\n2 remove station"
      choice = gets.to_i
      case choice
      when 0
        break
      when 1
        add_station_in_route(route)
      when 2
        remove_station_from_route(route)
      end
    end
  end

  def remove_station_from_route(route)
    puts 'Enter a number of station'
    @remote_station.puts_every_station
    route.remove_station(@remote_station.stations[gets.to_i])
  end

  def add_station_in_route(route)
    puts 'Enter a number of station'
    @remote_station.puts_every_station
    route.add_station(@remote_station.stations[gets.to_i])
  end
end
