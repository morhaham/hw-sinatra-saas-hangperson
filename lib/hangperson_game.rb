class HangpersonGame
  
  attr_accessor :word, :guesses, :wrong_guesses
  
  def guess letter
    letter =~ /^[a-zA-Z]+$/ or raise ArgumentError, "The guess cannot be empty"
    letter = letter.downcase
    if @word.include? letter and !@guesses.include? letter then
      @guesses += letter
      true
    elsif !@wrong_guesses.include? letter and !@word.include? letter then
      @wrong_guesses += letter
    else
      false
    end
  end
  
  def word_with_guesses 
    word_with = ''
    @word.each_char do |l|
      flag = false
      @guesses.each_char do |c|
        if c == l then
          word_with += c
          flag = true
        end
      end
      if !flag then
        word_with += '-'
      end
    end
    word_with
  end
  
  def check_win_or_lose
    if (@wrong_guesses + @guesses).size >= 7 then
      :lose
    elsif !word_with_guesses.include? '-' then
      :win
    else
      :play
    end
  end
      
  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
  end

  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end

end

def guess_several_letters game, letters
  letters =~ /^[a-zA-Z]+$/ or raise ArgumentError, "The guess cannot be empty"
  letters = letters.downcase
  letters.split('').each do |l|
    if game.word.include? l and !game.guesses.include? l then
    game.guesses += l
    else
      game.wrong_guesses += l
    end
  end
end