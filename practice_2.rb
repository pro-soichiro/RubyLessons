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