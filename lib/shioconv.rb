require 'yaml'
require 'ostruct'

require_relative "shioconv/version"
require_relative "shioconv/unit"
require_relative "shioconv/condiment"

class Shioconv
  attr_reader :condiment, :quantity, :unit

  def self.measure(condiment_name, quantity, unit)
    condiment = Condiment.find(condiment_name)
    unless !!condiment
      raise ArgumentError.new("condiment '#{condiment_name}' does not found.")
    end

    self.new(condiment: condiment, quantity: quantity, unit: unit)
  end

  def initialize(condiment: condiment, quantity: quantity, unit: unit)
    @condiment = condiment
    @quantity  = quantity
    @unit      = Unit.new(unit)
  end
end
