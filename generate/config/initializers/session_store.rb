# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_generate_session',
  :secret      => 'f7ec953daae19ad1e89eb17c4d2e3d0ff47e22a7d68f0c524c5f65a7fc4f52ca2e5c1b7ff6cb50547b1250ffd6e8adf16b7ed7bf6b246c5c66ee4012daaa586c'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
