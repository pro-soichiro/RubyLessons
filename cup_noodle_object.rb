# インスタントヌードルクラス
class Instant_noodle

  def boil
    puts "お湯を沸かします"
  end

  def pour
    puts "お湯を目盛まで入れます"
  end

  def wait(time)
    puts "#{time}分待ちます。"
  end

  def finish
    puts "完成です"
  end

end


class Peyangu < Instant_noodle

  def drain
    puts "お湯を切ります"
  end

  def item
    puts "副材料を入れます"
  end

end


class Donbee < Instant_noodle

  def item
    puts "副材料を入れます"
  end

end

cup_noodle = Instant_noodle.new
peyangu = Peyangu.new
donbee = Donbee.new
# それぞれのメソッドを呼び出す
# カップヌードル
cup_noodle.boil
cup_noodle.pour
cup_noodle.wait(3)
cup_noodle.finish

# ペヤング
peyangu.boil
peyangu.pour
peyangu.wait(3)
peyangu.drain
peyangu.item
peyangu.finish

# どん兵衛
donbee.boil
donbee.item
donbee.pour
donbee.wait(5)
donbee.finish