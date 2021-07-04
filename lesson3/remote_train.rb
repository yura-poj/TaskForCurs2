# frozen_string_literal: true

require_relative 'remote_route'
require_relative 'cargo_train'
require_relative 'passenger_train'

TRAIN_GUIDE = '0 - back 1 - create 2 - choose train'
class RemoteTrain
  attr_reader :trains

  def initialize(remote_route)
    @trains = []
    @remote_route = remote_route
  end

  def act_with_train
    loop do
      puts TRAIN_GUIDE
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

  def puts_every_train
    @trains.each_with_index { |train, n| puts "#{n} - #{train.number}" }
  end

  def choose_train
    puts 'Enter number of train'
    puts_every_train
    @trains[gets.to_i]
  end

  private

  def create_train
    loop do
      puts 'Enter the type 1 - cargo or 2 - passenger'
      choice = gets.to_i
      case choice
      when 0
        break
      when 1
        create_train_with_type(CargoTrain)
      when 2
        create_train_with_type(PassengerTrain)
      end
    end
  end

  def create_train_with_type(obj_with_type)
    puts 'Enter a number'
    @trains.push(obj_with_type.new(gets.chomp))
    puts "You create #{@trains.last.number} train"
  rescue StandardError => e
    puts e.message
    puts "try again...\n"
    retry
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
        act_with_route_of_train(train)
      end
    end
  end

  def act_with_carriage(train)
    loop do
      puts '0 - back 1 - add 2 - remove 3 - show all 4 - shooce carriage'
      choice = gets.to_i
      case choice
      when 0
        break
      when 1
        puts 'Enter number of space'
        train.add_carriage_with_own_type(gets.to_i)
      when 2
        train.remove_carriage
      when 3
        puts_every_carriage(train)
      when 4
        act_with_chosed_carriage(train)
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

  def act_with_route_of_train(train)
    loop do
      puts '0 - back 1 - add 2 - move'
      choice = gets.to_i
      case choice
      when 0
        break
      when 1
        train.add_route(@remote_route.choose_route)
      when 2
        train_move(train)
      end
    end
  end

  def puts_every_carriage(train)
    number = 0
    train.each_carriage do |carriage|
      puts "#{number} - #{carriage}"
      number += 1
    end
  end

  def act_with_chosed_carriage(train)
    carriage = choose_carriage(train)

    loop do
      puts '0 - back 1 - fill 2 - free'
      choice = gets.to_i
      case choice
      when 0
        break
      when 1
        carriage.take_space
      when 2
        carriage.rid_space
      end
    end
  end

  def choose_carriage(train)
    puts 'Enter a number'
    puts_every_carriage(train)
    train.carriages[gets.to_i]
  end
end
