def boil
  puts "お湯を沸かします"
end

def pour
  puts "お湯を目盛まで入れます"
end

def wait(time)
  puts "#{time}分待ちます。"
end

def drain
  puts "お湯を切ります"
end

def item
  puts "副材料を入れます"
end

def finish
  puts "完成です"
end

# カップヌードル
boil
pour
wait(3)
finish
# ペヤング
boil
pour
wait(3)
drain
item
finish
# どん兵衛
boil
item
pour
wait(5)
finish