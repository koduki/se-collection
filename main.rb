# -*- encoding: utf-8 -*-

class Character
  attr_accessor :name, :hp, :df

  def initialize name, hp
    @name = name
    @hp = hp
    @atk = 2
    @df = 1
  end

  def atack
    @atk * rand(3)
  end
end

class Battle
  def start c1, c2
    while true
      if c1.hp <= 0
        puts "#{c1.name} win."
        break
      elsif c2.hp <= 0
        puts "#{c1.name} lose."
        break
      end

      atack c1, c2
      atack c2, c1
    end
  end

  def atack c1, c2
    dmg = c2.atack - c1.df
    c1.hp -= dmg
    puts "#{c2.name} atack! #{c1.name} is #{dmg} damage."
  end
end

class System
  attr_accessor :money, :power
  def initialize money, power
    @money = money
    @power = power
  end
end

#==begin
# main
#=end

b = Battle.new
system = System.new 0, 11

progress = 0

step = lambda do
  puts "進む"
  system.power -= 1
  progress += 1

  p [progress, system]
end

event = lambda do |title|
  puts "#{title} 開始"
  while true do
    step.call

    if progress % 2 == 0
      c1 = Character.new "u1", 10
      c2 = Character.new "enamy", 10
      b.start c1, c2
    end

    if system.power == 0
      puts '行動値がなくなりました。ここから進めません'
      break
    elsif progress >= 10
      puts 'クリア'
      break
    end
  end
  puts "#{title} 終了"
end

puts "==========="
puts "Game Start "
puts "==========="

event.call '第１話'
event.call '第２話'
