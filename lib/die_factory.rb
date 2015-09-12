module DieFactory

  extend self

  def create(input_file)
    File.readlines(input_file).map do |line|
      Die.new(sides: line.chomp.chars)
    end
  end

end
