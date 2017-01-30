require "sinatra"
require "sinatra/reloader"

set :number => rand(100)

@@guess = 0

def check_guess(guess)
  if @@guess > 5
    settings.number = rand(100)
    @@guess = 0
    "Sorry you lost, there is now a new number"
  else
    @@guess += 1
    if guess != nil
      if guess.to_i > settings.settings.number
        if guess.to_i - 5 > settings.number
          "Way too high!"
        else
          "Too high!"
        end
      elsif guess.to_i < settings.number
        if guess.to_i + 5 < settings.number
          "Way too low!"
        else
          "Too low!"
        end
      elsif guess.to_i == settings.number
        settings.number = rand(100)
        @@guess = 0
        "You got it right!"
      end
    else
      ""
    end
  end
end

get "/" do
  guess = params["guess"]
  cheat = params["cheat"]
  message = check_guess(guess)
  erb :index, :locals => {:number => settings.number, :message => message, :cheat => cheat}
end
