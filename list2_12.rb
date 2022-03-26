class Human
  def initialize(p_name)
    @name = p_name
  end

  def name
    @name
  end
end

taro = Human.new("山田太郎")
puts taro.name