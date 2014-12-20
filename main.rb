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
  def start player_deck, enemy_deck
    c1 = player_deck.first
    c2 = enemy_deck.first

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

player_deck = [Character.new("PC1", 1000)]

progress = 0

step = lambda do
  puts "進む"
  system.power -= 1
  progress += 1

  p [progress, system, player_deck]
end


discovery = lambda do
  c = Character.new("PC#{player_deck.size + 1}", rand(3))
  player_deck << c
  p ['カード発見', player_deck]
end

event = lambda do |title|
  puts "#{title} 開始"
  while true do
    step.call

    if progress % 2 == 0
      enemy_deck = [Character.new("enemy1", 5)]
      b.start player_deck, enemy_deck
    else
      discovery.call
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

senario = lambda do |events|
  events.each do |e|
    event.call e
  end
end

puts "==========="
puts "Game Start "
puts "==========="

senario.call ['第１話', '第２話']
