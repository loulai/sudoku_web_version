require 'sinatra' 
require_relative './lib/sudoku'
require_relative './lib/cell'

enable :sessions
set :session_secret, '*&(^B234'

def random_sudoku
  seed = (1..9).to_a.shuffle + Array.new(81-9, 0)
  sudoku = Sudoku.new(seed.join)
  sudoku.solve!
  sudoku.to_s.chars
end

def puzzle(sudoku)
  kinda_empty_sudoku = sudoku.dup #both filled right now
  40.times {kinda_empty_sudoku[rand(81)]=""} #making the change
  kinda_empty_sudoku #changed
end

get '/' do # default route for our website
  sudoku = random_sudoku
  session[:solution] = sudoku
  @current_solution = puzzle(sudoku)
  erb :index
end

get '/solution' do
  @current_solution = session[:solution]
  erb :index
end


# this is the link we read to solve our session problem: 
# http://stackoverflow.com/questions/18044627/sinatra-1-4-3-use-racksessioncookie-warning