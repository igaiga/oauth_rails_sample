# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_service_provider_session',
  :secret      => '9cc37c3e7f9dcbfe8563b78f1994eb395eafae08f104fa8beee3817f184ad4c2e5e9f2d19cd6f273991c70673d5e34913af74fb419f1895ecc2626a6002a7f92'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
