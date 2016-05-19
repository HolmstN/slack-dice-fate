require 'sinatra'
require 'json'

post '/roll' do
  text = params[:text].strip ||= ''

  if text =~ /-?\d+/
    total = roll text.to_i
    display_message "You rolled a #{total}"
  else
    display_message "Must follow format: '\/roll \<num\>'"
  end
end

def display_message(message)
  content_type :json
  {:text => message}.to_json
end

def roll(modifier)
  die = [-1, 0, 1]

  rolls = []
  4.times { rolls << die.sample }

  roll_value = rolls.inject(:+) + modifier
end
