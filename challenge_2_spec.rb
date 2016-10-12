require_relative 'test_helper'
require_relative 'utils'
require_relative 'challenge_2'

RSpec.describe Challenge2 do

  describe '#interpolate_g_yield' do
    it 'returns yield at target term based on linear interpolation of provided data points' do
      # NOTE: already sorted by term
      data_points = [
        {term: 1, yield: 1},
        {term: 2, yield: 2},
        {term: 3, yield: 2.5}
      ]

      expect( Challenge2.interpolate_g_yield(data_points, 1.5) ).to eq(1.5)
      expect( Challenge2.interpolate_g_yield(data_points, 2.5) ).to eq(2.25)
    end
  end

  describe '#spread_to_curve' do
    it 'calculates the correct spread to curve for each corporate bond' do
      c_bonds = [
        make_bond('C1', 10.3, 5.3),
        make_bond('C2', 15.2, 8.3)
      ]
      g_bonds = [
        make_bond('G1', 9.4, 3.7),
        make_bond('G2', 12, 4.8),
        make_bond('G3', 16.3, 5.5)
      ]

      results = Challenge2.spreads_to_curve(c_bonds, g_bonds)

      expect(results[0][:bond]).to eq('C1')
      expect(results[0][:spread_to_curve].round(2)).to eq(1.22)

      expect(results[1][:bond]).to eq('C2')
      expect(results[1][:spread_to_curve].round(2)).to eq(2.98)
    end
  end

  describe '#main' do
    context 'malformed CSV' do
      it 'prints error to stderr' do
        ARGV = ['malformed_csv.csv']
        expect do
          Challenge2.main 
        end.to output("Malformed CSV file!\n").to_stderr
      end
    end
  end
end

