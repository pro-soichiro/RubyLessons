fruits = ["りんご","いちご","パイナップル","ぶどう"]

number = 0
while number != 9
  puts "フルーツ番号を入力してください（終了は9です）"
  number = gets.to_i

  if number == 1
    puts fruits[0]
  elsif number == 2
    puts fruits[1]
  elsif number == 3
    puts fruits[2]
  elsif number == 4
    puts fruits[3]
  else
    puts "該当なし"
  end

end
puts "終了します"