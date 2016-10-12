require 'spec_helper'
require 'challenge_1'

RSpec.describe Challenge1 do
  describe '#calculate_spreads' do
    context 'properly-formed CSV' do
      it 'calculates C1 correctly' do
        c_bounds = [
          make_bond('C1', 10.3, 5.3)
        ]
        g_bounds = [
          make_bond('G1', 9.4, 3.7),
          make_bond('G2', 12, 4.8)
        ]

        c1 = Challenge1.calculate_spreads(c_bounds, g_bounds).first
        expect(c1[:bond]).to eq('C1')
        expect(c1[:benchmark]).to eq('G1')
        expect(c1[:spread]).to eq(1.6)
      end
    end
  end

  describe '#main' do
    context 'malformed CSV' do
      it 'prints error to stderr' do
        ARGV = ['./spec/fixtures/malformed_csv.csv']
        expect do
          Challenge1.main 
        end.to output("Malformed CSV file!\n").to_stderr
      end
    end
  end
end
