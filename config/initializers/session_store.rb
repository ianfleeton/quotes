# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_woodworking_quote_session',
  :secret      => '47ee11273d80155e40fe1212d3c65ffa40d012f66be6859d9b82ae350ef9f8152ede692b51953f64ec7873135180ed70000ea6e5d10560e10e45f67f8eff3da5'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
