class Shioconv::Condiment < OpenStruct
  def self.find(condiment)
    # find by key
    if condiment.is_a?(Symbol)
      result = raw_data.find { |data| data[:key] == condiment }
      return self.new(result) if result
    end

    # find by name
    condiment = condiment.to_s.downcase
    [:japanese_name, :english_name].each do |key|
      result = raw_data.find { |data| data[key] == condiment }
      return self.new(result) if result
    end

    # find by synonyms
    result = raw_data.find { |data| data[:synonyms].include?(condiment) }
    return self.new(result) if result

    nil
  end

  def self.data_file
    File.join(File.dirname(File.expand_path(__FILE__)), %w(.. .. config condiments.yaml))
  end

  def self.raw_data
    @@raw_data ||= YAML.parse(File.read(data_file)).to_ruby
  end
end
