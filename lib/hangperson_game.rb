class HangpersonGame
  attr_accessor :word, :guesses, :wrong_guesses
  
  def guess letter 
    if @word.include? letter and !@guesses.include? letter then
      @guesses += letter
      true
    elsif !@wrong_guesses.include? letter and !@word.include? letter then
      @wrong_guesses += letter
    else
      false
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
  letters.split('').each do |l|
    if game.word.include? l and !game.guesses.include? l then
    game.guesses += l
    else
       game.wrong_guesses += l
    end
  end
end

# game = HangpersonGame.new('hello')
# guess_several_letters(game,'ge')

# p game.guess('e')
