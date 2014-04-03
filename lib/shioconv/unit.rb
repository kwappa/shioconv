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

  def initialize(unit)
    UNIT_TYPES.each do |unit_type, units|
      if units.has_key?(unit)
        @type  = unit_type
        @name  = unit
        @value = units[unit]
        break
      end
    end
    raise ArgumentError.new("unit [#{unit}] does not found.") unless @name
  end
end
