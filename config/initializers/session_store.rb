# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_megatron_session',
  :secret      => 'ee9d627112441bbfcc2a44f790cd4ab98e1f706c24676ba7cc6af31c5739be3da59a38b6cef8c5a182b21e9fb4ff7fe3c0b9ff80a1486e7f1443d48e601b9340'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
