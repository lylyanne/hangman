class Game
  DICTIONARY = ["cinderella", "jazz", "goblet", "eradicate"]
 
  def initialize
    @computer = Computer.new
    @player = Player.new
    @play_area = Array.new(@computer.answer.length)
    @available_letter = ("a".."z").to_a
    @remaining_tries = 5
  end
 
  def play
    while @remaining_tries > 0
      display_play_area
      current_guess = @player.guess
      @remaining_tries -= 1 if !check_answer(current_guess)
      return "You win!" if win?
    end

    return "You lose!"
  end

  def display_play_area
    puts "Available letter selections are: #{@available_letter.inspect}"
    list = ""
    @play_area.length.times do |i|
      list << (@play_area[i] == nil ? "_ " : "#{@play_area[i]} ")
    end
    puts list
    puts "You have #{@remaining_tries} remaining tries"
    puts
  end

  def check_answer(current_guess)
    valid_guess = false
    
    if @play_area.include?(current_guess) || !@available_letter.include?(current_guess)
        puts "You guessed that letter already"
        puts
        valid_guess = true
    elsif @computer.answer.include?(current_guess) #Update play_area if the user makes correct guess
      @play_area.length.times do |i|
        if @computer.answer[i] == current_guess
          @play_area[i] = current_guess 
          valid_guess = true
        end
      end
    end

    @available_letter.delete(current_guess)
    valid_guess
  end

  def win?
    @computer.answer == @play_area
  end
end

class Computer
  attr_reader :answer

  def initialize
    @answer = get_code
  end

  def get_code
    Game::DICTIONARY.sample(1).first.split('')
  end
end

class Player
  def guess
    puts "Enter a letter"
    player_guess = gets.chomp
    player_guess.downcase
  end
end