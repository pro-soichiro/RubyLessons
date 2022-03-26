# 変数の参照範囲の違い

# ローカル変数 greeting 同一メソッド内
# インスタンス変数 @greeting 同一インスタンス内
# クラス変数 @@greeting 同一クラスおよびそのインスタンス内
# グローバル変数 $greeting どこからでも

class A
  def a1
    @@hensu = "クラス1"
    @hensu = "インスタンス1"
    hensu = "ローカル1"
    @local = hensu
  end

  def a2
    @@hensu = "クラス2"
    @hensu = "インスタンス2"
    hensu = "ローカル2"
    @local = hensu
  end

  def go
    puts @@hensu
    puts @hensu
    puts @local
  end
end

# インスタンスinst1とinst2を生成
inst1 = A.new
inst2 = A.new

# インスタンスinst1のa1メソッドを実行
inst1.a1 #=> それぞれの変数に値を代入

# 各インスタンスのgoメソッドを実行
inst1.go
inst2.go #=>クラス変数のみ代入されている
