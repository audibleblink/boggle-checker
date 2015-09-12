class Die

  attr_accessor :neighbors

  def initialize(args={})
    @sides = args.fetch(:sides, [])
    @visited = false
    @neighbors = []
  end

  def visited?
    @visited
  end

  def visit!
    @visited = true
  end

  def unvisit!
    @visited = false
  end

  def upside
    @upside || toss
  end

  def toss
    @upside = sides.sample
  end

  def to_s
    upside.to_s
  end

  attr_reader :sides

end
