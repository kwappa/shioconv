require 'yaml'
require 'csv'

csv = CSV.read('./condiments.tsv', col_sep: "\t")
csv.shift                       # drop title row

result = csv.each_with_object({}) do |cols, r|
  (symbol, japanese_name, english_name, specific_gravity, *aliases) = cols.map(&:to_s)
  next if symbol.empty?
  aliases = aliases.find_all { |al| !al.empty? }.map(&:to_sym)

  r[symbol.to_sym] = {
    symbol: symbol.to_sym,
    japanese_name: japanese_name,
    english_name: english_name,
    specific_gravity: specific_gravity.to_f,
    aliases: aliases
  }
end

File.open('./condiments.yaml', 'w') { |yaml|
  yaml.write YAML.dump(result)
}

p result
