class GuessingGame
  attr_reader :num_attempts
  # attr_reader :num_attempts, :game_over?
  # https://stackoverflow.com/questions/4013591/attr-reader-with-question-mark-in-a-name
  # alias_method :server_error?, :server_error


  def initialize(min, max)
    @min = min
    @max = max
    @secret_num = rand(@min..@max)
    @num_attempts = 0
    @game_over = false
    # @game_over? = false
  end

  def game_over?
    @game_over
  end

  def check_num(num)
   if num==@secret_num
    @num_attempts += 1
    @game_over = true
    puts 'you win'
   elsif num>@secret_num
    @num_attempts += 1
    puts 'too big'
   else
    @num_attempts += 1
    puts 'too small'
   end
  end

  def ask_user
    p 'enter a number'
    u_input = gets.chomp.to_i
    check_num(u_input)
  end
end
