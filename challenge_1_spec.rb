require 'rubygems'
require 'bundler/setup'
require_relative 'challenge_1'

RSpec.describe Challenge1 do
  describe '#calculate_spreads' do
    context 'properly-formed CSV' do
      let :csv_data do
        File.read('sample_input.csv')
      end

      it 'prints the header row' do
        expect do
          Challenge1.calculate_spreads csv_data
        end.to output(/\Abond,benchmark,spread_to_benchmark\n/).to_stdout
      end

      it 'prints the first data row correctly' do
        expect do
          Challenge1.calculate_spreads csv_data
        end.to output(/\nC1,G1,1.60%\n/).to_stdout
      end

      it 'prints the last data row correctly' do
        expect do
          Challenge1.calculate_spreads csv_data
        end.to output(/\nC7,G6,2.50%\n\z/).to_stdout
      end
    end

    context 'malformed CSV' do
      it 'prints to stderr that the file is malformed' do
        malformed_csv = File.open('malformed_csv.csv').read
        expect do
          Challenge1.calculate_spreads malformed_csv
        end.to output("Malformed CSV file!\n").to_stderr
      end
    end
  end
end
