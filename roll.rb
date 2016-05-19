require 'sinatra'
require 'json'

post '/roll' do
  text = params[:text].strip ||= 0

  if text =~ /-?\d+/
    total = roll text.to_i
    display_message_channel "You rolled a #{total}"
  else
    display_message_user "Must follow format: '\/roll \<num\>'"
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

def roll(modifier)
  die = [-1, 0, 1]

  rolls = []
  4.times { rolls << die.sample }

  roll_value = rolls.inject(:+) + modifier
end
