require File.join(Rails.root,'lib','openshift_secret_generator.rb')
# Be sure to restart your server when you modify this file.

# Your secret key is used for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!

# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
# You can use `rake secret` to generate a secure secret key.

# Make sure your secret_key_base is kept private
# if you're sharing your code publicly.
# Prode::Application.config.secret_key_base = '7133e5db82bac9bed1e95ed9e13d7f3f708cc73c0302fdbc5a4c5e70dcabec8fa4f43bda36d2fc97eaac0c5afd3251115d16924451d3b483eb781c84a625d1f9'
RailsApp::Application.config.secret_token = initialize_secret(
  :token,
  '335a4e365ef2daeea969640d74e18f0e3cd9fae1abd8f4125691a880774ea6d456a29c0831aa6921bf86a710fe555e916f0673f5657619ec9df22e0409bec345'
)
