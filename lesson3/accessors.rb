# frozen_string_literal: true
require 'byebug'
module Accessors
  def attr_accessor_with_history(*args)
    args.each do |name|
      var_name = "@#{name}".to_sym
      var_name_history = "#{name}_history".to_sym
      var_self_name_history = "@#{var_name_history}".to_sym
      define_method(var_name_history) {instance_variable_get(var_self_name_history)}
      define_method(name) {instance_variable_get(var_name)}
      define_method("#{name}=") do |value|
        instance_variable_set(var_name, value)
        instance_variable_set(var_self_name_history, []) unless instance_variable_get(var_self_name_history)
        instance_variable_get(var_self_name_history).push(value)
      end
    end
  end
end