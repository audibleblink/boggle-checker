require_relative 'die'
require_relative 'lib/die_factory'

class BoggleBoard
  attr_reader :board

  def initialize(dice)
    @board = prepare_board(dice) # 2d array; [['Qu', <Die>],['R', <Die>]]
  end

  def search(word, poss_dice=values)
    return true if word.empty?
    first, rest = word.slice(0,1).upcase, word.slice(1..-1).upcase
    dice = poss_dice.select { |die| first == die.upside && !die.visited? }

    dice.any? do |current_die|
      current_die.visit!
      result = search(rest, current_die.neighbors)
      unvisit_all!
      result
    end
  end

  def shake!
    @board = prepare_board(values.shuffle)
  end

  def to_s
    keys.each_slice(4).map { |row| row.join("    ") }.join("\n\n")
  end

  private

  def values
    board.map{ |_,die| die }
  end

  def keys
    board.map{ |name,_| name }
  end

  def unvisit_all!
    values.each { |die| die.unvisit! }
  end

  def prepare_board(dice)
    populate_neighbors(dice)
    dice.reduce([]) { |memo, die| memo.push( [die.upside, die] ) }
  end

  def populate_neighbors(dice)
    dice.each_with_index do |die, index|
      neighbors = neighboring_indices_for(index)
      neighbors.each { |n_ind| die.neighbors << dice[n_ind] }
    end
  end

  def neighboring_indices_for(index)
    coords = index.divmod(4)
    surrounding_coords_for(coords).map { |coord| coords_to_index(coord) }
  end

  def coords_to_index(coords)
    coords.first * 4 + coords.last
  end

  def surrounding_coords_for(coords)
    (-1..1).each_with_object([]) do |num_x, final|
      (-1..1).each do |num_y|
        next if num_y.zero? && num_x.zero?
        maybs = [coords[0] + num_x, coords[1] + num_y]
        final.push(maybs) if valid_coordinates?(maybs)
      end
    end
  end

  def valid_coordinates?(crds)
    (0..3).include?(crds.first) && (0..3).include?(crds.last)
  end

end
