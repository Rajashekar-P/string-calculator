require 'rspec'
require_relative 'string_calculator'

RSpec.describe StringCalculator do
  describe '.add' do
    it 'returns 0 for an empty string' do
      expect(StringCalculator.add("")).to eq(0)
    end

    it 'returns the number for a single number' do
      expect(StringCalculator.add("1")).to eq(1)
      expect(StringCalculator.add("5")).to eq(5)
    end

    it 'returns the sum for two numbers' do
      expect(StringCalculator.add("1,2")).to eq(3)
      expect(StringCalculator.add("10,20")).to eq(30)
    end

    it 'returns the sum for an unknown amount of numbers' do
      expect(StringCalculator.add("1,2,3,4,5")).to eq(15)
      expect(StringCalculator.add("10,20,30")).to eq(60)
    end

    it 'handles new lines as delimiters' do
      expect(StringCalculator.add("1\n2,3")).to eq(6)
      expect(StringCalculator.add("4\n5\n6")).to eq(15)
    end

    it 'supports different delimiters' do
      expect(StringCalculator.add("//;\n1;2")).to eq(3)
      expect(StringCalculator.add("//|\n4|5|6")).to eq(15)
    end

    it 'supports delimiters of any length' do
      expect(StringCalculator.add("//[***]\n1***2***3")).to eq(6)
      expect(StringCalculator.add("//[##]\n4##5##6")).to eq(15)
    end

    it 'supports multiple delimiters' do
      expect(StringCalculator.add("//[*][%]\n1*2%3")).to eq(6)
      expect(StringCalculator.add("//[**][%%]\n4**5%%6")).to eq(15)
    end

    it 'raises an exception for negative numbers' do
      expect { StringCalculator.add("1,-2,3,-4") }.to raise_error("Negative numbers are not allowed")
    end

    it 'ignores numbers greater than 1000' do
      expect(StringCalculator.add("2,1001")).to eq(2)
      expect(StringCalculator.add("1000,1001,1002,3")).to eq(1003)
    end
  end
end
