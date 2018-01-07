class BSTNode
    def initialize(value, parent = nil)
    @value = value
    @children = []
    @parent = parent
  end
  def parent=(node)
    @parent = node
  end
  def parent
    @parent
  end
  def value
    @value
  end
  def children
    @children
  end
  def children=(arr)
    @children = arr
  end
  def left=(node)
    @children[0]=node
  end
  def left
    @children[0]
  end
  def right=(node)
    @children[1]=node
  end
  def right
    @children[1]
  end

end
