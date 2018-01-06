require '/home/snorkeboy/Desktop/firstname_lastname/lib/bst_node.rb'

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
      @root = BSTNode.new(value)
      return @root
    end

    insertRec(@root, value)
  end

  def insertRec(node, value)
    if (value>node.value)
      !node.right ? node.right=BSTNode.new(value) : insertRec(node.right, value)
    else
      !node.left ? node.left=BSTNode.new(value) : insertRec(node.left, value) 
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

  def findParent(value, tree_node = @root)

    if (tree_node == nil)
      return nil
    end
    if (tree_node.value == value)
      return tree_node
    end
    if (tree_node.children.empty?)
        return nil
    end

    if (value > tree_node.value)
      if (tree_node.right && tree_node.right.value == value)
        return tree_node
      else
        return findParent(value, tree_node.right)
      end
    else
      if (tree_node.left && tree_node.left.value == value)
        return tree_node
      else
        return findParent(value,tree_node.left)
      end
    end
  end

  def delete(value, node = @root)
    # if deleting root
    if (@root.value == value)
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

    # find parent of node to be deleted
    # if child  has no children simply delete its reference in parent
    # if one child swap parents reference to child with grandchild
    # if 2 children find max of left and swap
    parent = findParent(value, node)
    # child is what we are tring to delete
    child_idx = parent.children.find_index{|child| child.value == value}

    child = parent.children[child_idx]
    # if not found
    return if !parent || !child

    grandchildren = child.children.select{|grandchild| grandchild != nil}
    if (grandchildren.empty?)
      parent.children[child_idx] = nil
    elsif(grandchildren.length == 1)
      parent.children[child_idx] = grandchildren[0]
    else
      # child has 2 grandchildren. Find the max node to childs left, its parent,
      # and its chilren (it should only have possibly left child)

      max = maximum(child.left)
      max_parent = findParent(max.value, child.left)
      max_left = max.left
      
      # swap max node into childs spot by setting childs children to max children
      # delete child by setting its parents reference to it to max
      # delete max from its original position using max_parent

      max.children = child.children
      parent.children[child_idx] = max
      max_parent.right = max_left

    end
  end
  # helper method for #delete:
  def maximum(tree_node = @root)
    while (tree_node.right != nil)
      tree_node = tree_node.right
    end
    tree_node
  end

  def depth(tree_node = @root)
    p tree_node
    depth = 0
    while (tree_node)
      tree_node = tree_node.left
      depth = depth +1
    end
    depth

  end 

  def is_balanced?(tree_node = @root)
  end

  def in_order_traversal(tree_node = @root, arr = [])
  end


  private
  # optional helper methods go here:

end
