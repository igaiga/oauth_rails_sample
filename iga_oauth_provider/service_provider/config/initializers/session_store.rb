# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_service_provider_session',
  :secret      => '523d52607eae9a64bd435694a3126a17d15b7f00d5fa04163b56e92a37dbf873a1e906a63f9dd2b193ee90e58be7172f88c613538d425091d78956b59295c8e9'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
