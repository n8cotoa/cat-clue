require("bundler/setup")
Bundler.require(:default)
Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }
require 'pry'

get('/') do
  @spaces = Space.all
  @space = "A1"
  erb(:board)
end

get('/board/:coordinates') do
  binding.pry
  redirect '/'
end
