require_relative "shioconv/version"
require 'yaml'

class Shioconv
  def self.measure(condiment, quantity, unit)
    condiment_data = find_condiment(condiment)
    unless !!condiment_data
      raise ArgumentError.new("condiment '#{condiment}' does not found.")
    end

    self.new(condiment_data: condiment_data, quantity: quantity, unit: unit)
 end

  def self.condiments
    @@condiments ||= YAML.parse(File.read(condiments_data_file)).to_ruby
  end

  def self.find_condiment(condiment)
    # find by key
    if condiment.is_a?(Symbol)
      result = condiments.find { |condiments_data| condiments_data[:key] == condiment }
      return result if result
    end

    # find by name
    condiment = condiment.to_s.downcase
    [:japanese_name, :english_name].each do |key|
      result = condiments.find { |condiments_data| condiments_data[key] == condiment }
      return result if result
    end

    # find by synonyms
    condiments.find { |condiment_data| condiment_data[:synonyms].include?(condiment) }
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
