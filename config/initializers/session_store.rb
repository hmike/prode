require File.join(Rails.root,'lib','openshift_secret_generator.rb')
# Be sure to restart your server when you modify this file.

# Prode::Application.config.session_store :cookie_store, key: '_prode_session'
RailsApp::Application.config.session_store :cookie_store, :key => initialize_secret(
  :session_store,
  '_railsapp_session'
)
