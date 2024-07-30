class StringCalculator
  def self.add(numbers)
    return 0 if numbers.empty?

    delimiters = [",", "\n"]
    if numbers.start_with?("//")
      delimiter_spec, numbers = numbers.split("\n", 2)
      custom_delimiters = delimiter_spec.scan(/\[([^\]]+)\]/).flatten
      delimiters.concat(custom_delimiters)
      delimiters << delimiter_spec[2] if custom_delimiters.empty?
    end

    delimiter_regex = Regexp.union(delimiters)
    nums = numbers.split(delimiter_regex).map(&:to_i)

    negatives = nums.select { |n| n < 0 }
    raise "Negative numbers are not allowed" if negatives.any?

    nums.reject { |n| n > 1000 }.sum
  end
end
