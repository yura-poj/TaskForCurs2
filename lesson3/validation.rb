# frozen_string_literal: true

require 'byebug'

module Validation
  def self.included(base)
    base.extend(ClassMethods)
    base.include(InstanceMethods)
  end

  module ClassMethods
    def validate(value, type_of_validation, equality_value = nil)
      @valids ||= []
      @valids.push(send(type_of_validation, value, equality_value))
    end

    attr_accessor :valids

    private

    def presence(value, equality_value)
      name_of_method = "#{value}_presence"
      value = "@#{value}".to_sym
      define_method(name_of_method) { raise "#{value} can not be empty" if instance_variable_get(value).nil? || instance_variable_get(value).strip.empty?}
      name_of_method
    end

    def format(value, equality_value)
      name_of_method = "#{value}_format"
      value = "@#{value}".to_sym
      define_method(name_of_method) { raise 'value have wrong format' if instance_variable_get(value) !~ equality_value}
      name_of_method
    end

    def type(value, equality_value)
      name_of_method = "#{value}_type"
      value = "@#{value}".to_sym
      define_method(name_of_method) { raise 'value have wrong class' if instance_variable_get(value).class != equality_value}
      name_of_method
    end
  end

  module InstanceMethods
    def valid!
      self.class.valids.each{|name_of_method| send(name_of_method)}
    end

    def valid?
      valid!
      true
    rescue RuntimeError
      false
    end
  end
end

