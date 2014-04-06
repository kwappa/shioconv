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
        return self.new(type: unit_type, name: unit_name, value: units[unit_name])
      end
    end

    raise ArgumentError.new("unit [#{unit_name}] does not found.") unless @name
  end

  def self.convertable?(unit)
    CONVERTABLE_UNITS.include?(unit)
  end

  def self.list
    UNIT_TYPES.map do |type, units|
      (base_unit, _) = units.shift
      "#{type}: #{base_unit}, " << units.map { |unit, value| "#{unit}(#{value}#{base_unit})" }.join(', ')
    end
  end

  def initialize(type: type, name: name, value: value)
    @type  = type
    @name  = name
    @value = value
  end

  def convert(condiment, quantity, dst_unit)
    return quantity if name == dst_unit
    dst_unit = self.class.find_by(dst_unit)

    current_vavlue = quantity * value / dst_unit.value
    if type == :weight && dst_unit.type == :volume
      current_vavlue /= condiment.specific_gravity
    elsif type == :volume && dst_unit.type == :weight
      current_vavlue *= condiment.specific_gravity
    end

    current_vavlue
  end
end
