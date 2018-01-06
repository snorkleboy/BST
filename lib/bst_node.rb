class BSTNode
    def initialize(value)
    @value = value
    @children = []
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
