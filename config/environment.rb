# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Prode::Application.initialize!

# force Rails to use development
ENV['RAILS_ENV'] = 'development'

#Set default date format
Date::DATE_FORMATS.merge!(:default => "%d/%m/%Y")