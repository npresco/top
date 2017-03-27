require "sinatra"
require_relative "../../ruby_building_blocks/caesar_cipher.rb"

set :sessions, key:            "N&wedhSDF",
               expire_after:   14_400,
               secret:         "*&(^B234"

get "/" do
  erb :index, locals: { cipher: session[:cipher] }
end

post "/cipher" do
  session[:cipher] = caesar_cipher(params[:cipher], params[:rotation].to_i)
  redirect "/"
end
