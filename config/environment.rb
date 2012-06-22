# Load the rails application
require File.expand_path('../application', __FILE__)
require 'pusher'

Pusher.app_id = 22686
Pusher.key = '7f1590723727b1a008b1'
Pusher.secret = '4fa63da43b54cd350d48'

# Initialize the rails application
LsTrivia::Application.initialize!
