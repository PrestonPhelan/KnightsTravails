require_relative 'polytreenode'

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
      land_pos = [pos.first + move.first, pos[1] + move[1]]
      next if land_pos.any? { |value| value < 0 || value > 7 }
      landing_positions << land_pos
    end

    landing_positions
  end

  def initialize(start_position)
    @start = start_position
    @visited_positions = [start_position]
    @move_tree = build_move_tree
  end

  def build_move_tree
    ##Code that builds move tree, and stores it in instance variable
    root = PolyTreeNode.new(start)
    moves = [root]

    ##Queue
    positions_to_check = [root]

    until positions_to_check.empty?
      current_node = positions_to_check.shift
      new_moves = new_move_positions(current_node.value)

      new_moves.each do |end_pos|
        new_node = PolyTreeNode.new(end_pos)
        new_node.parent = current_node
        moves << new_node
        positions_to_check << new_node
      end
    end

    moves
  end

  def new_move_positions(pos)
    possible_moves = KnightPathFinder.valid_moves(pos)
    new_moves = possible_moves.reject do |position|
      visited_positions.include?(position)
    end

    new_moves.each { |move| visited_positions << move }
    new_moves
  end

  def find_path(end_pos)
    end_node = @move_tree.first.bfs(end_pos)

    trace_back_path(end_node)
  end

  def trace_back_path(node)
    path = [node.value]

    current_node = node
    while current_node.parent
      next_node = current_node.parent
      path.unshift(next_node.value)
      current_node = next_node
    end

    path
  end

end


if __FILE__ == $PROGRAM_NAME
  kpf = KnightPathFinder.new([0, 0])
  #
  # p KnightPathFinder.valid_moves([0, 0])
  #
  # p kpf.new_move_positions(kpf.start)
  # p kpf.visited_positions
  # kpf.move_tree.first.children.each do |child|
  #   p child.value
  # end

  p kpf.find_path([7, 6])
  p kpf.find_path([6, 2])
end
