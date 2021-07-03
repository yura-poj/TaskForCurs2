# Имеет начальную и конечную станцию, а также список промежуточных станций. Начальная и конечная станции указываютсся
# при создании маршрута, а промежуточные могут добавляться между ними.
# Может добавлять промежуточную станцию в список
# Может удалять промежуточную станцию из списка
# Может выводить список всех станций по-порядку от начальной до конечной
require_relative 'station'
class Route
  attr_reader :route_list

  def initialize(start_station:, finish_station:)
    @route_list = [start_station, finish_station]
    valid!
  end

  def valid?
    valid!
    true
  rescue StandardError
    false
  end

  def add_station(station:)
    @route_list.insert(1, station)
  end

  def delete_station(obj:)
    return 'impossible' if obj == @route_list[0] && obj == route_list[-1]

    @route_list.delete(obj)
  end

  private

  def valid!
    raise 'Value is not object' if @route_list.first.class != Class || @route_list.last.class != Class
  end
end

__END__
route = Route.new(start: '1', finish: '2')
puts route.route_list.inspect
route.add_station(name: '2.5')
route.delete_station(obj: route.route_list[1])
puts route.route_list.inspect

puts route.route_list.class