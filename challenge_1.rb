require_relative 'utils'

module Challenge1
  def self.main
    if file_path = ARGV.first
      csv_data = File.read(file_path)
      c_bonds, g_bonds = Utils.parse_csv(csv_data)

      puts 'bond,benchmark,spread_to_benchmark'

      Challenge1.calculate_spreads(c_bonds, g_bonds).each do |c_bond| 
        printf "%s,%s,%.2f%\n", c_bond[:bond], c_bond[:benchmark], c_bond[:spread]
      end
    end
  rescue CSV::MalformedCSVError
    $stderr.puts 'Malformed CSV file!'
  end

  def self.calculate_spreads(c_bonds, g_bonds)
    c_bonds.map do |c_bond|
      benchmark = g_bonds.min_by do |g_bond|
        (g_bond[:term] - c_bond[:term]).abs
      end

      spread = c_bond[:yield] - benchmark[:yield]
      c_bond.merge(benchmark: benchmark[:bond], spread: spread)
    end
  end
end

Challenge1.main
