require 'sinatra'
require 'sinatra/reloader'

require 'erubis'
set :erb, :escape_html => true

load './game.rb'

use Rack::Session::Pool, :expire_after => 2592000

def run callback
  @system = session['system']
  @senario = session['senario']
  @event = session['event']
  @console = []

  callback.call

  @console = [@system, @senario, @event] + @console
end

def bind key, value
  session[key] = value
  eval("@#{key} = session[key]")
end

get '/init' do
  run lambda {
    bind('system', System.new(1000, 100))
    bind('senario', nil)
    bind('event', nil)
  }
  erb :index
end

get '/' do
  erb :index
end

get '/senario' do
  run lambda {
    bind('senario', [Event.new(0, '第1話', 0, 1), Event.new(1, '第2話', 0, 1)])

    @console << 'Hello!'
  }
  erb :senario
end

get '/event/:name' do
  run lambda {
    bind('event', @senario[params[:name].to_i])
  }
  erb :event
end

get '/event/:name/next' do
  run lambda {
    @event.next @system
  }
  erb :event
end
