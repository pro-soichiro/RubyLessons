class Human
  attr_accessor :name

  def initialize(aaa)
    @name = aaa
  end

  def handshake(other_person)
    puts "#{name}は、#{other_person.name}さんと握手しました！"
  end
end