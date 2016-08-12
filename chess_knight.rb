class Node
  attr_accessor :value, :parent, :child_1, :child_2, :child_3, :child_4, :child_5, :child_6, :child_7, :child_8
  def initialize(value = nil, parent = nil, child_1 = nil, child_2 = nil, child_3 = nil, child_4 = nil, child_5 = nil, child_6 = nil, child_7 = nil, child_8 = nil)
    @value = value
    @parent = parent
    @child_1 = child_1
    @child_2 = child_2
    @child_3 = child_3 
    @child_4 = child_4 
    @child_5 = child_5 
    @child_6 = child_6 
    @child_7 = child_7 
    @child_8 = child_8 
  end
end

class MovesTree
  attr_accessor :head
  def initialize(start_ary)
    @head = Node.new(start_ary)
  end

  def build_tree(tmp = @head, moved = [])
    #return @head  if moved.length == 64 #recursion ends when base case met ( all 64 places on the chessboard has been visited at least once )
    queue = []
    moved << tmp.value
    while moved.length < 64
      #visits all possible moves in one turn, should find a way to refactor
      unless [tmp.value[0]+2, tmp.value[1]+1].any? { |num| num < 0 || num > 7} || moved.include?([tmp.value[0]+2, tmp.value[1]+1])
        tmp.child_1 = Node.new([tmp.value[0]+2, tmp.value[1]+1], tmp) 
        moved << [tmp.value[0]+2, tmp.value[1]+1] 
        queue << tmp.child_1
      end    

      unless [tmp.value[0]+2, tmp.value[1]-1].any? { |num| num < 0 || num > 7} || moved.include?([tmp.value[0]+2, tmp.value[1]-1])
        tmp.child_2 = Node.new([tmp.value[0]+2, tmp.value[1]-1], tmp) 
        moved << [tmp.value[0]+2, tmp.value[1]-1]
        queue << tmp.child_2
      end

      unless [tmp.value[0]+1, tmp.value[1]-2].any? { |num| num < 0 || num > 7} || moved.include?([tmp.value[0]+1, tmp.value[1]-2])
        tmp.child_3 = Node.new([tmp.value[0]+1, tmp.value[1]-2], tmp) 
        moved << [tmp.value[0]+1, tmp.value[1]-2]

        queue << tmp.child_3
      end

      unless [tmp.value[0]-1, tmp.value[1]-2].any? { |num| num < 0 || num > 7} || moved.include?([tmp.value[0]-1, tmp.value[1]-2])
        tmp.child_4 = Node.new([tmp.value[0]-1, tmp.value[1]-2], tmp) 
        moved << [tmp.value[0]-1, tmp.value[1]-2]
        queue << tmp.child_4
      end

      unless [tmp.value[0]-2, tmp.value[1]-1].any? { |num| num < 0 || num > 7} || moved.include?([tmp.value[0]-2, tmp.value[1]-1])
        tmp.child_5 = Node.new([tmp.value[0]-2, tmp.value[1]-1], tmp) 
        moved << [tmp.value[0]-2, tmp.value[1]-1]
        queue << tmp.child_5
      end

      unless [tmp.value[0]-2, tmp.value[1]+1].any? { |num| num < 0 || num > 7} || moved.include?([tmp.value[0]-2, tmp.value[1]+1])
        tmp.child_6 = Node.new([tmp.value[0]-2, tmp.value[1]+1], tmp) 
        moved << [tmp.value[0]-2, tmp.value[1]+1]
        queue << tmp.child_6
      end

      unless [tmp.value[0]-1, tmp.value[1]+2].any? { |num| num < 0 || num > 7} || moved.include?([tmp.value[0]-1, tmp.value[1]+2])
        tmp.child_7 = Node.new([tmp.value[0]-1, tmp.value[1]+2], tmp) 
        moved << [tmp.value[0]-1, tmp.value[1]+2]
        queue << tmp.child_7
      end

      unless [tmp.value[0]+1, tmp.value[1]+2].any? { |num| num < 0 || num > 7} || moved.include?([tmp.value[0]+1, tmp.value[1]+2])
        tmp.child_8 = Node.new([tmp.value[0]+1, tmp.value[1]+2], tmp) 
        moved << [tmp.value[0]+1, tmp.value[1]+2]
        queue << tmp.child_8

      end #all (8 at most) cases visited and put into tree
      tmp = queue.shift
    end
  end

  def breadth_first_search(ending_point)
    queue = [] #using queue data structure (fifo)
    temp = @head
    finished = false
    while finished == false
      #queue.each {|i| p i.value}
      if temp.value == ending_point
        finished = true
        return temp
      end

      queue << temp.child_1 if temp.child_1 != nil
      queue << temp.child_2 if temp.child_2 != nil
      queue << temp.child_3 if temp.child_3 != nil
      queue << temp.child_4 if temp.child_4 != nil
      queue << temp.child_5 if temp.child_5 != nil
      queue << temp.child_6 if temp.child_6 != nil
      queue << temp.child_7 if temp.child_7 != nil
      queue << temp.child_8 if temp.child_8 != nil

      if queue.empty?
        finished = true
        p 'you entered incorrect data, please try again'
      end
      temp = queue.shift
    end
  end

  def output(ending_point)
    themp = breadth_first_search(ending_point)
    moves = []
    count = 0
    while themp != nil
moves << themp.value
      themp = themp.parent
      count += 1
    end
    puts "You made it in #{count} moves! Here's your path:"
    moves.reverse.each { |move| puts move.to_s }

  end
end

def knight_moves(start_ary, end_ary)
a = MovesTree.new(start_ary)
a.build_tree
p a.output(end_ary)
end
