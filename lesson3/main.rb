# frozen_string_literal: true

require_relative 'remote_route'
require_relative 'remote_train'
require_relative 'remote_station'
#      - Создавать станции
#      - Создавать поезда
#      - Создавать маршруты и управлять станциями в нем (добавлять, удалять)
#      - Назначать маршрут поезду
#      - Добавлять вагоны к поезду
#      - Отцеплять вагоны от поезда
#      - Перемещать поезд по маршруту вперед и назад
#      - Просматривать список станций и список поездов на станции

class Conductor
  GREETING = "0 - exit\n 1 - act with stations \n2 - act with route \n3 - act with train"
  METHODS = { 1 => :act_with_station, 2 => :act_with_route, 3 => :act_with_route }.freeze
  TYPE_ERROR_MESSAGE = 'Enter a right number'

  def initialize
    @remote_station = RemoteStation.new
    @remote_route = RemoteRoute.new(@remote_station)
    @remote_train = RemoteTrain.new(@remote_route)
  end

  def start
    loop do
      puts GREETING
      choice = gets.to_i
      break if choice.zero?

      send METHODS[choice]
    rescue TypeError
      puts TYPE_ERROR_MESSAGE
    end
  end

  private

  def act_with_station
    @remote_station.act_with_station
  end

  def act_with_route
    @remote_route.act_with_route
  end

  def act_with_train
    @remote_train.act_with_train
  end
end

# __END__
user = Conductor.new
user.start
