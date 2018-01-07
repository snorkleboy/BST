require 'bst_node'

# There are many ways to implement these methods, feel free to add arguments 
# to methods as you see fit, or to create helper methods.

class BinarySearchTree
  def root
    @root
  end
  def initialize
    @root = nil
  end

  def insert(value)

    if (@root == nil)
      @root = BSTNode.new(value, nil)
      return @root
    end

    insertRec(@root, value)
  end

  def insertRec(node, value)
    if (value>node.value)
      !node.right ? node.right=BSTNode.new(value,node) : insertRec(node.right, value)
    else
      !node.left ? node.left=BSTNode.new(value,node) : insertRec(node.left, value) 
    end
  end

  def find(value, tree_node = @root)
    if ( tree_node == nil)
      return nil
    end
    if (value == tree_node.value)
      return tree_node
    end

    if (value > tree_node.value)
      find(value, tree_node.right)
    else
      find(value,tree_node.left)
    end
  end



  def delete_root()
    if (!@root.children.empty?)
        max = maximum(@root.left)
        max_parent = findParent(value, @root.left)
        max_left = max.left
        
        max.children = @root.children
        @root = max
        max_parent.right = max_left
        return
      end
      @root = nil
      return 
  end
  def delete(value)

    # if deleting root
    if (@root.value == value)
      delete_root()
      return
    end
    # if child  has no children simply delete its reference in parent
    # if one grandchild swap parents reference to child with grandchild
    # if 2 children find max of left and swap


    # child is what we are tring to delete
    child =find(value)
    # if not found
    return if !child
    parent = child.parent
    child_idx = parent.children.find_index{|child| child.value == value}
    

    grandchildren = child.children.select{|grandchild| grandchild != nil}
    if (grandchildren.empty?)
      parent.children[child_idx] = nil
    elsif(grandchildren.length == 1)
      parent.children[child_idx] = grandchildren[0]
      grandchildren[0].parent = parent
    else
      # child has 2 grandchildren. Find the max node to childs left, its parent,
      # and its chilren (it should only possibly have left child)

      max = maximum(child.left)
      max_parent = max.parent
      max_left = max.left
      
      #put grandchildren on max and reset their parent to max
      max.children = child.children
      max.children.each{|child| child.parent = max}

      #have max take childs place in the tree
      parent.children[child_idx] = max
      max.parent = parent

      #replace max's old position with max's old children
      max_parent.right = max_left
      max_left.parent = max_parent

    end
  end
  # helper method for #delete:
  def maximum(tree_node = @root)
    while (tree_node.right != nil)
      tree_node = tree_node.right
    end
    tree_node
  end
  def self.maximum(tree_node = @root)
    while (tree_node.right != nil)
      tree_node = tree_node.right
    end
    tree_node
  end

  #max depth
  def depth(tree_node = @root)
  #get depth of left and right, return max
    if (tree_node == nil)
      return -1
    else
      return [depth(tree_node.left),depth(tree_node.right)].max + 1
    end 
  end

  def is_balanced?(tree_node = @root)
    (depth(@root.left) - depth(@root.right)).abs ==  0
  end

  def in_order_traversal(tree_node = @root, arr = [])

    if (tree_node.children.empty?)
      arr.push(tree_node.value)
      return 
    end

    in_order_traversal(tree_node.left,arr)  if (tree_node.left) 
    arr.push(tree_node.value)
    in_order_traversal(tree_node.right, arr) if (tree_node.right) 
    arr
  end


  private
  # optional helper methods go here:

end
