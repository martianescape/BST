class Bst 
  class Node
    attr_accessor :lChild, :rChild, :key
    def initialize(key)
      @key = key
      @lChild = nil
      @rchild = nil
    end
  end

  attr_accessor :root
  
  def add(key, curr)
    if @root == nil; @root = Node.new(key); end
    if curr == nil; return Node.new(key); end
    if key < curr.key; curr.lChild = add(key, curr.lChild)
    else; curr.rChild = add(key, curr.rChild)
    end
    curr = balance(curr)
    puts "inside add #{curr.key}"
      display_tree()
    return curr
  end

  def balance(curr)
    
    bFactor = height(curr.rChild) - height(curr.lChild)
    if bFactor == 2
      rbFactor = height(curr.rChild.rChild) - height(curr.rChild.lChild)
      if rbFactor == -1; rRotation(curr.rChild); end
      new_parent = lRotation(curr)
      return new_parent
    elsif bFactor == -2
      puts "now i am at bfactor -2"
      lbFactor = height(curr.lChild.rChild) - height(curr.lChild.lChild)
      if lbFactor == 1; lRotation(curr.lChild); end
      display_tree()
      puts "sent curr node for rRotation = #{curr.key}"
      new_parent = rRotation(curr)
      puts "sent after curr node for rRotation = #{curr.key}"
      display_tree()
      puts "balanced #{curr.key}"
      $stdin.gets
      return new_parent
    else; return curr
    end
    puts "balanced #{curr.key}"
    $stdin.gets

  end

  def add1(key, curr)
    parent, curr = find_parent(key, nil, @root)
    if parent == nil; @root = Node.new(key); 
    else; add_child(parent, key, Node.new(key))
    end
  end

  def lRotation(node)
    rChildNode = node.rChild
    parent, curr = find_parent(node.key, nil, @root)
    #update node
    node.rChild = rChildNode.lChild
    #update rChildNode
    rChildNode.lChild = node
    #update parent
    if parent != nil; add_child(parent, rChildNode.key, rChildNode)
    #update root
    else; @root = rChildNode
    end
    return rChildNode
  end

  def rRotation(node)
    lChildNode = node.lChild
    parent, curr = find_parent(node.key, nil, @root)
    #update node
    node.lChild = lChildNode.rChild
    #update lChildNode
    lChildNode.rChild = node
    #update parent
    if parent != nil; add_child(parent, lChildNode.key, lChildNode)
    #update root
    else; @root = lChildNode
    end
    return lChildNode
  end

  def search(key)
    parent, curr = find_parent(key, nil, @root)
    if curr == false; return false;
    else return true
    end
  end

  def right_most_node(curr, parent)
    if curr.rChild == nil; return curr, parent; end
    return right_most_node(curr.rChild, curr)
  end


  def display(curr)
    if curr == nil; return; end
    display(curr.lChild)
    print "#{curr.key}  "
    display(curr.rChild)
  end

  def find_parent(key, parent, curr)
    if curr == nil; return parent, false; end
    if curr.key == key; return parent, curr; end
    if key < curr.key; return find_parent(key, curr, curr.lChild)
    else; return find_parent(key, curr, curr.rChild);
    end
  end

  def add_child(parent, key, child)
    if key < parent.key; parent.lChild = child
    else; parent.rChild = child; 
    end
  end

  def height(curr)
    if curr == nil; return 0; end
    lSubtreeHeight = height(curr.lChild)
    rSubtreeHeight = height(curr.rChild)
    return 1 + (lSubtreeHeight > rSubtreeHeight ? lSubtreeHeight : rSubtreeHeight)
  end

  def level(node, curr = @root)
    if curr == node; return 0; end
    if node.key < curr.key; return 1 + level(node, curr.lChild);
    else return 1 + level(node, curr.rChild); 
    end
  end

  def display_tree()
    queue = []
    queue << @root
    currLevel = 0
    #puts "height of root is #{height(@root)}"
    nodesPrinted = 0 
    i = 0

    while i < 2**height(@root) - 1
      if queue[i] == nil; queue << nil; queue << nil
      else
        #puts "queue[0].lChild #{queue[i].lChild}, queue.rChild = #{queue[i].rChild}" 
        queue << queue[i].lChild; queue << queue[i].rChild 
      end
      i += 1
    end
    while queue.length != 0 
      print " " * (2**(height(@root) -currLevel )) 
      if queue[0] != nil; print "#{queue.delete_at(0).key}"
      else; print ""; queue.delete_at(0)
      end
      nodesPrinted += 1 
      print " " * (2**(height(@root) -currLevel )) 
      if nodesPrinted >= 2**(currLevel+1) - 1
        currLevel += 1
        puts ""
      end
    end
  end 


def delete(key)
  parent, curr = find_parent(key, nil, @root)
    if curr == false; puts "node not found"; return; 
    end
    
    puts "height of key #{key} = #{height(curr)}" 
    replNode = nil
    replNodeParent = nil
    if curr.lChild != nil
      replNode, replNodeParent = right_most_node(curr.lChild, curr)
    end
    #update parentNode
    if parent == nil && curr.lChild == nil; replNode = nil; @root = curr.rChild;
    elsif parent == nil; @root = replNode
    else
      if curr.lChild == nil; add_child(parent, curr.key, curr.rChild) 
      else; add_child(parent, curr.key, replNode)
      end 
    end
    #update replNode and replNodeParent
    if curr.lChild != nil
      if curr.lChild != replNode; replNode.lChild = curr.lChild; end
      if curr.rChild != replNode; replNode.rChild = curr.rChild; end
      add_child(replNodeParent, replNode.key, nil)
    end
    parent, curr = find_parent(, nil, @root)
    
  end
end

tree = Bst.new

  puts "adding 3"
  tree.add(3, tree.root)
  tree.display(tree.root)
  puts tree.display_tree()
  #$stdin.gets
  
  puts "before adding 1"
  tree.add(1, tree.root)
  tree.display(tree.root)
  puts tree.display_tree()
  #$stdin.gets
  
  puts "before adding 0"
  tree.add(0, tree.root)
  tree.display(tree.root)
  puts tree.display_tree()
  #$stdin.gets
  
  puts "before adding 2"
  tree.add(2, tree.root)
  tree.display(tree.root)
  puts tree.display_tree()
  #$stdin.gets
  
  puts "before adding 5"
  tree.add(5, tree.root)
  tree.display(tree.root)
  puts tree.display_tree()
  #$stdin.gets
  
  puts "before adding 4"
  tree.add(4, tree.root)
  tree.display(tree.root)
  puts tree.display_tree()
  #$stdin.gets
  
  puts "before adding 8"
  tree.add(8, tree.root)
  tree.display(tree.root)
  puts tree.display_tree()
  #$stdin.gets
  
  puts "before adding 7"
  tree.add(7, tree.root)
  tree.display(tree.root)
  puts tree.display_tree()
  #$stdin.gets
 
  puts "before adding 7.5"
  tree.add(7.5, tree.root)
  tree.display(tree.root)
  puts tree.display_tree()
  $stdin.gets
 
  puts "before adding 12"
  tree.add(12, tree.root)
  puts "before adding 13"
  tree.add(13, tree.root)
  puts "***********displaying tree******* "
  tree.display(tree.root)
  puts tree.display_tree()
  puts "************displayed*************"
  #puts "height of the root 3 is #{tree.height(tree.root)}"



  puts "before adding 35"
tree.add(35,tree.root)
  puts "before adding 30"
tree.add(30,tree.root)
  puts "before adding 32"
tree.add(32,tree.root)


puts "tree walaa tree"
tree.display_tree()
#tree.rRotation(tree.root)
tree.display_tree()
puts "search is #{tree.search(7)}"
tree.delete(ARGV[0].to_f)
puts "deleting #{ARGV[0]}"
tree.display(tree.root)
