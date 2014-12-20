require 'sinatra'
require 'sinatra/reloader'

load './game.rb'

enable :sessions

get '/' do
  erb :index
end

get '/senario' do
  erb :senario
end

get '/event/:name' do
  erb :event
end
