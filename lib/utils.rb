require 'csv'
require 'bigdecimal'


module Utils


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
