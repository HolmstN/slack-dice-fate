require 'sinatra'
require 'json'

post '/roll' do
  text = params[:text] || "0"

  if text =~ /[+-]?\d+/
    roll_values = roll
    total = roll_values.inject(:+) + text.to_i
    display_message_channel "You rolled #{roll_values} for \*#{total}\*"
  else
    display_message_user "Must follow format: '\/roll (\+\/\-)num'"
  end
end

def display_message_channel(message)
  content_type :json
  {
    :response_type => "in_channel",
    :text => message
  }.to_json
end

def display_message_user(message)
  content_type :json
  {
    :text => message
  }.to_json
end

# Should reformat this to return the array of rolls, then inject elsewhere.
def roll
  die = [-1, 0, 1]

  rolls = []
  4.times { rolls << die.sample }

  rolls
end
