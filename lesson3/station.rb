# frozen_string_literal: true

# Имеет название, которое указывается при ее создании
# Может принимать поезда (по одному за раз)
# Может возвращать список всех поездов на станции, находящиеся в текущий момент
# Может возвращать список поездов на станции по типу (см. ниже): кол-во грузовых, пассажирских
# Может отправлять поезда (по одному за раз, при этом, поезд удаляется из списка поездов, находящихся на станции).
class Station
  attr_reader :trains_list, :name

  def self.all
    p ObjectSpace.each_object(self).to_a
  end

  def initialize(name)
    @name = name
    @trains_list = []
    valid!
  end

  def valid?
    valid!
    true
  rescue StandardError
    false
  end

  def add_train(train)
    @trains_list << train
  end

  # type is :cargo or :passenger
  def return_trains_by_type(type)
    (@trains_list.map { |a| a if a.type == type }).compact
  end

  def train_leave
    @trains_list.shift
  end

  def each_train(&block)
    @trains_list.each(&block)
  end

  private

  def valid!
    raise 'value is empty' if @name.nil? || @name == ''
  end
end
__END__
station = Station.new(name: 'd')
station.add_train(number_carriage: 2, type: :freight, number: 1)
station.add_train(number: 2, type: :passenger, number_carriage: 2)
puts station.return_trains_on_type(type: :freight).inspect
station.train_leave
puts station.trains_list.inspect
