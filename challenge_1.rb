require 'csv'
require 'bigdecimal'

module Challenge1

  def self.calculate_spreads(csv_data)

    puts 'bond,benchmark,spread_to_benchmark'

    c_bonds, g_bonds = parse_csv(csv_data)
    c_bonds.each do |c_bond|
      benchmark = g_bonds.min_by do |g_bond|
        (g_bond[:term] - c_bond[:term]).abs
      end

      spread = c_bond[:yield] - benchmark[:yield]
      printf "%s,%s,%.2f%\n", c_bond[:bond], benchmark[:bond], spread
    end

  rescue CSV::MalformedCSVError
    $stderr.puts 'Malformed CSV file!'
  end

  def self.parse_csv(csv_data)
    c_bonds, g_bonds = [], []
    CSV.parse(csv_data, headers: true) do |row| 
      case row['type']
      when 'corporate'
        c_bonds << parse_row(row)
      when 'government'
        g_bonds << parse_row(row)
      end
    end
    return c_bonds, g_bonds
  end

  def self.parse_row(row)
    {
      bond: row['bond'],
      term: BigDecimal(row['term'][0..-6]),
      yield: BigDecimal(row['yield'][0..-2])
    }
  end

end

if file_path = ARGV.first
  csv_data = File.read(file_path)
  Challenge1.calculate_spreads(csv_data)
end
