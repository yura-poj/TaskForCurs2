# frozen_string_literal: true

require 'byebug'

module Validation
  def self.included(base)
    base.extend(ClassMethods)
    base.include(InstanceMethods)
  end

  module ClassMethods
    def validate(value, type_of_validation, equality_value = nil)
      @a ||= 0
      @valids ||= []
      @valids.push(send(type_of_validation, value, equality_value))
    end

    attr_accessor :valids

    private

    def presence(value, equality_value)
      name = change_name(value)
      value = "@#{value}".to_sym
      define_method(name) { raise 'value is empty' if instance_variable_get(value).nil? || instance_variable_get(value).strip.empty?}
      name
    end

    def format(value, equality_value)
      name = change_name(value)
      value = "@#{value}".to_sym
      define_method(name) { raise 'value have wrong format' if instance_variable_get(value) !~ equality_value}
      name
    end

    def type(value, equality_value)
      name = change_name(value)
      value = "@#{value}".to_sym
      define_method(name) { raise 'value have wrong class' if instance_variable_get(value).class != equality_value}
      name
    end

    def change_name(name)
      @a += 1
      "#{name}#{@a}".to_sym
    end
  end

  module InstanceMethods
    def valid!
      self.class.valids.each{|a| send(a)}
    end

    def valid?
      valid!
      true
    rescue StandardError
      false
    end

    def get_it
      instance_variable_get(value)
    end
  end
end

