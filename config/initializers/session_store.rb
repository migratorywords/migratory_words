# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_heroku_session',
  :secret      => '0d66a3b448cc9847b348db24edfbb80be2a51d5949d9786f81f940ecec2b35de776c1a70eeaf5aa07efe162dcf7fa3b8b1d341f43d341effc3a068acefa9f8fa'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
