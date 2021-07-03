require_relative 'carriage'
class PassengerCarriage < Carriage
  attr_reader :taked_space

  def initialize(number_of_space = 50)
    @taked_space = 0
    @number_of_space = number_of_space
    super()
  end

  def take_space
    return 'you dont have a free seats' if @taked_space >= @number_of_space

    @taked_space += 1
  end

  def rid_space
    return 'you dont have passengers' if @taked_space.zero?

    @taked_space -= 1
  end

  def free_space
    @number_of_space - @taked_space
  end

  def type
    :passenger
  end
end

__END__
user = PassengerCarriage.new(10)
user.initialize_manufacturer('dsd')
p user.free_space
