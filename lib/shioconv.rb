require_relative "shioconv/version"
require 'yaml'

class Shioconv
  def self.measure(condiment, quantity, unit)
    condiment_data = find_condiment(condiment)
    unless !!condiment_data
      raise ArgumentError.new("condiment #{condiment} does not found.")
    end

    self.new(condiment_data: condiment_data, quantity: quantity, unit: unit)
 end

  def self.condiments
    @@condiments ||= YAML.parse(File.read(condiments_data_file)).to_ruby
  end

  def self.find_condiment(condiment)
    if condiments.has_key?(condiment)
      condiments[condiment]
    else
      condiments.find { |condiment_data| condiment_data[:aliases].include?(condiment) }
    end
  end

  def self.condiments_data_file
    File.join(File.dirname(File.expand_path(__FILE__)), %w(.. config condiments.yaml))
  end

  def initialize(condiment_data: condiment_data, quantity: quantity, unit: unit)
    @condiment_data = condiment_data
    @quantity       = quantity
    @unit           = unit
  end
end
