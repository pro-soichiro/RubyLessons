class Person

  def use
    puts "道具を使う"
  end

  def speak
    puts "言葉を話す"
  end

end

class Japanese < Person
  def speak
    super
    puts "日本語を話す"
  end
end

yamada_taro = Japanese.new
yamada_taro.speak