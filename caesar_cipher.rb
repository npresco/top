require "sinatra"

set :sessions, key:            "N&wedhSDF",
               expire_after:   14_400,
               secret:         "*&(^B234"

def caesar_cipher(sentence, number=0)
  upcases = ("A".."Z").to_a
  downcases = ("a".."z").to_a

  downhash = Hash[("a".."z").to_a.zip((0..25).to_a)]
  uphash = Hash[("A".."Z").to_a.zip((0..25).to_a)]

  letters = sentence.split("")

  letters.map! do |x|
    if downhash.include? x
      x = downhash[x] + number
      x -= 26 while x > 25
      x = downcases[x]
    elsif uphash.include? x
      x = uphash[x] + number
      x -= 26 while x > 25
      x = upcases[x]
    else
      x
    end
  end
  p letters.join
end

get "/" do
  erb :index, locals: { cipher: session[:cipher] }
end

post "/cipher" do
  session[:cipher] = caesar_cipher(params[:cipher], params[:rotation].to_i)
  redirect "/"
end
