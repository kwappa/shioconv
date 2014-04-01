require 'yaml'
require 'csv'

csv = CSV.read('./condiments.tsv', col_sep: "\t")
csv.shift                       # drop title row

result = csv.each_with_object([]) do |cols, r|
  (key, japanese_name, english_name, specific_gravity, *synonyms) = cols.map(&:to_s)
  next if key.empty?
  synonyms = synonyms.find_all { |al| !al.empty? }.map(&:downcase)

  r << {
    key: key.to_sym,
    japanese_name: japanese_name,
    english_name: english_name,
    specific_gravity: specific_gravity.to_f,
    synonyms: synonyms
  }
end

File.open('./condiments.yaml', 'w') { |yaml|
  yaml.write YAML.dump(result)
}

p result
