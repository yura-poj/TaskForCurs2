require_relative 'cargo_train'
require_relative 'passenger_train'

class RemoteTrain
  def initialize
    @guide_about_train = '0 - back 1 - create 2 - choose train'
    @trains = []
  end

  def act_with_train
    loop do
      puts @guide_about_train
      choice = gets.to_i
      case choice
      when 0
        break
      when 1
        create_train
      when 2
        act_with_chosed_train
      end
    end
  end

  private

  def puts_every_train
    @trains.each_with_index { |train, n| puts "#{n} - #{train.number}" }
  end

  def create_train
    loop do
      puts 'Enter the type 1 - cargo or 2 - passenger'
      choice = gets.to_i
      case choice
      when 0
        break
      when 1
        create_cargo_train
      when 2
        create_passenger_train
      end
    end
  end

  def create_cargo_train
    puts 'Enter a number'
    @trains.push(CargoTrain.new(gets.to_i))
  end

  def create_passenger_train
    puts 'Enter a number'
    @trains.push(PassengerTrain.new(gets.to_i))
  end

  def act_with_chosed_train
    train = choose_train
    loop do
      puts "0 - exit to back \n1 - act_with_carriage \n2 - act with route"
      choice = gets.to_i
      case choice
      when 0
        break
      when 1
        act_with_carriage(train)
      when 2
        act_with_route_of_train
      end
    end
  end

  def choose_train
    puts 'Enter number of train'
    puts_every_train
    @trains[gets.to_i]
  end

  def act_with_carriage(train)
    loop do
      puts '0 - back 1 - add 2 - remove'
      choice = gets.to_i
      case choice
      when 0
        break
      when 1
        train.add_carriage_with_own_type
      when 2
        train.remove_carriage
      end
    end
  end

  def train_move(train)
    loop do
      puts '0 - back 1 - move next 2 - move back'
      choice = gets.to_i
      case choice
      when 0
        break
      when 1
        train.next_station
      when 2
        train.previous_station
      end
    end
  end

  def choose_route
    puts 'Enter number of route'
    puts_every_route
    @routes[gets]
  end

  def puts_every_route
    route.each_with_index { |route, n| puts "#{n} - #{route}" }
  end

  def act_with_route_of_train
    loop do
      puts '0 - back 1 - add 2 - move'
      choice = gets.to_i
      case choice
      when 0
        break
      when 1
        @train.add_route(choose_route)
      when 2
        train_move
      end
    end
  end
end
