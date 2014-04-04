require 'yaml'
require 'ostruct'

require_relative "shioconv/version"
require_relative "shioconv/unit"
require_relative "shioconv/condiment"

class Shioconv
  attr_reader :condiment, :quantity, :unit

  def self.measure(condiment_name, quantity, unit_name)
    condiment = Condiment.find_by(condiment_name)
    unit      = Unit.find_by(unit_name)

    self.new(condiment: condiment, quantity: quantity, unit: unit)
  end

  def initialize(condiment: condiment, quantity: quantity, unit: unit)
    @condiment = condiment
    @quantity  = quantity
    @unit      = unit
  end
end
