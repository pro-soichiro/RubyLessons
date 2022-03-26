# Taroオブジェクトの定義

class Taro
  def name
    name = "山田太郎"
  end
end

# Topicオブジェクトの定義

class Topic
  def show_name
    puts "Taroの名前を表示します"
    # 名前の取得
    taro = Taro.new
    puts taro.name
  end
end

# Topicクラスをインスタンス化してshow_nameメソッドを実行する

topic = Topic.new
topic.show_name