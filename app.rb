require("bundler/setup")
Bundler.require(:default)
Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }
require 'pry'

get('/') do
  @spaces = Space.all.order(:id)
  erb(:board)
end

get('/board/:coordinates') do
  redirect '/'
end
