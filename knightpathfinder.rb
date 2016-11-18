# require 'polytreenode'

class KnightPathFinder
  attr_accessor :visited_positions
  attr_reader :start, :move_tree

  MOVES = [
    [1, 2], [1, -2], [-1, 2], [-1, -2],
    [2, 1], [2, -1], [-2, 1], [-2, -1]
  ]

  def self.valid_moves(pos)
    landing_positions = []

    MOVES.each do |move|
      land_pos = [ pos.first + move.first, pos[1] + move[1]]
      next if land_pos.any? { |value| value < 0 || value > 7 }
      landing_positions << land_pos
    end

    landing_positions
  end

  def initialize(start_position)
    @start = start_position
    @visited_positions = [start_position]
    #@move_tree = build_move_tree
  end

  # def build_move_tree
  #   ##Code that builds move tree, and stores it in instance variable
  #   moves = { start => nil }
  #
  #   ##Queue
  #   positions_to_check = [start]
  #
  #   until positions_to_check.empty?
  #     current_pos = positions_to_check.shift
  #     new_moves = new_move_positions(current_pos)
  #
  #     new_moves.each do |end_pos|
  #       moves[end_pos] = current_pos
  #     end
  #     positions_to_check += new_moves
  #   end
  #
  #   moves
  # end

  def new_move_positions(pos)
    possible_moves = KnightPathFinder.valid_moves(pos)
    new_moves = possible_moves.reject do |position|
      visited_positions.include?(position)
    end

    new_moves.each { |move| visited_positions << move }
    new_moves
  end

  def find_path(end_pos)

  end

end


if __FILE__ == $PROGRAM_NAME
  kpf = KnightPathFinder.new([0, 0])

  p KnightPathFinder.valid_moves([0, 0])

  p kpf.new_move_positions(kpf.start)
  p kpf.visited_positions
  # p kpf.move_tree
end
