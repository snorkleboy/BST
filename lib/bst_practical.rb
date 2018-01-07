require 'binary_search_tree'

    # go all the way to the right
    # save that node as the 'parent row'
    # go left, 
    # try to repeat "go all the way to the right"
    # try to repeat go left
    # go to 'parent row'
    # repeat from 'go left'

    #every node vistited will be nth largest

def kth_largest(node, k)
    largest = BinarySearchTree.maximum(node)
    return largest if (k==1)

    (1...k).each do
        largest = next_largest(largest)
    end
    
    largest
end

def next_largest(node)
    node.left ? BinarySearchTree.maximum(node.left) : next_largest_parent(node)   
end

def next_largest_parent(node)
    while(node.parent.value>node.value)
        node = node.parent
    end
    node.parent
end
