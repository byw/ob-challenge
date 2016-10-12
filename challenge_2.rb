require_relative 'utils'

module Challenge2

  def self.main
    csv_data = File.read(ARGV.first)
    c_bonds, g_bonds = Utils.parse_csv(csv_data)
    Challenge2.spreads_to_curve(c_bonds, g_bonds).each do |c_bond| 
      printf "%s,%.2f%\n", c_bond[:bond], c_bond[:spread_to_curve]
    end
  end

  def self.spreads_to_curve(c_bonds, g_bonds)
    sorted_g_bonds = g_bonds.sort_by { |b| b[:term] }

    c_bonds.map do |c_bond|
      curve_yield = interpolate_g_yield(sorted_g_bonds, c_bond[:term])
      spread = c_bond[:yield] - curve_yield
      c_bond.merge(spread_to_curve: spread)
    end
  end

  def self.interpolate_g_yield(sorted_g_bonds, target_term)
    upper_index = sorted_g_bonds.find_index do |g_bond|
      g_bond[:term] > target_term
    end

    upper_bond = sorted_g_bonds[upper_index]
    lower_bond = sorted_g_bonds[upper_index - 1]

    x0, y0 = lower_bond[:term], lower_bond[:yield]
    x1, y1 = upper_bond[:term], upper_bond[:yield]
    x = target_term

    y0 + (x - x0) * ((y1 - y0) / (x1 - x0))
  end
end

Challenge2.main
