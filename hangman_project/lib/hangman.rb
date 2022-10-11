class Hangman
  DICTIONARY = ["cat", "dog", "bootcamp", "pizza"]

  attr_reader :guess_word, :attempted_chars, :remaining_incorrect_guesses

  def self.random_word
    DICTIONARY.sample
  end

  def initialize
    # @secret_word = Hangman.random_word
    @secret_word = self.class.random_word
    # @guess_word = Array.new(@secret_word.length, "_")
    @guess_word =  ('_'*@secret_word.length).split('')
    @attempted_chars = []
    @remaining_incorrect_guesses = 5
  end

  def already_attempted?(c)
    return true if @attempted_chars.include?(c)
    false
  end

  def get_matching_indices(c)
    (0...@secret_word.length).select{|i| c==@secret_word[i]}
  end

  def fill_indices(c, arr)
    arr.each{|i| @guess_word[i]=c}
  end

  def try_guess(c)
    if already_attempted?(c)
      puts 'that has already been attempted'
      return false
    else
      idxs = get_matching_indices(c)
      @remaining_incorrect_guesses -= 1 if idxs.empty?
      fill_indices(c, idxs)
      @attempted_chars << c
      return true
    end
  end

  def ask_user_for_guess
    puts 'Enter a char:'
    u_input = gets.chomp
    try_guess(u_input)
  end

  def win?
    return false if @guess_word.join('') != @secret_word
    puts 'WIN'
    true
  end

  def lose?
    return false if @remaining_incorrect_guesses != 0
    puts 'LOSE'
    true
  end

  def game_over?
    if win? || lose?
      puts @secret_word
      return true
    end
    false
  end

end
