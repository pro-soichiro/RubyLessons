# 4
capital = { "日本" => "東京",
            "USA" => "ワシントン",
            "UK" => "ロンドン",
            "フランス" =>  "パリ",
            "中国" => "北京"}

puts capital["日本"]
puts capital["USA"]
puts capital["UK"]
puts capital["フランス"]
puts capital["中国"]

# 5

capital2 = {"アジア" =>
              {
                "日本" => "東京",
                "中国" => "北京"
              },
            "北米" =>
              {
                "USA" => "ワシントン"
              },
            "ヨーロッパ" =>
              {
                "UK" => "ロンドン",
                "フランス" =>  "パリ"
              }
            }

puts capital2["ヨーロッパ"]["UK"]
puts capital2["北米"]["USA"]

# 6
# 連接構造

# 分岐構造 if

# 繰り返し構造 while

# 7

class Human
  attr_accessor :name

  def initialize(name)
    @name = name
  end
end

mamiya = Human.new("間宮")
puts mamiya.name


# 8
class Adder
  def total(num1,num2)
    puts num1 + num2
  end
end

adder = Adder.new
adder.total(2,4)

# 9
class Calculator < Adder
  def difference(num1,num2)
    puts num1 - num2
  end
end

calculator = Calculator.new
calculator.difference(4,3)
calculator.difference(4,5)
calculator.total(4,5)