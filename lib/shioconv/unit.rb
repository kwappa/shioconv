class Shioconv::Unit
  attr_reader :type, :name, :value

  UNIT_TYPES = {
    volume: {
      cc:        1.0,
      ml:        1.0,
      tbsp:     15.0,
      tsp:       5.0,
      cup:     200.0,
      us_cup:  236.56,
      jp_cup:  200.0,
    },
    weight: {
      g:         1.0,
      kg:     1000.0,
      oz:       28.349,
      lb:      453.592,
    },
  }.freeze

  CONVERTABLE_UNITS = UNIT_TYPES.map { |_, units| units.keys }.flatten.freeze

  def self.find_by(unit_name)
    UNIT_TYPES.each do |unit_type, units|
      if units.has_key?(unit_name)
        return self.new(unit: unit_type, name: unit_name, value: units[unit_name])
      end
    end

    raise ArgumentError.new("unit [#{unit_name}] does not found.") unless @name
  end

  def self.convertable?(unit)
    CONVERTABLE_UNITS.include?(unit)
  end

  def initialize(type: type, unit: unit, value: value)
    @type  = type
    @unit  = unit
    @value = value
  end
end
