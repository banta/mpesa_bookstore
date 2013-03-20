# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_Bookstore_session',
  :secret      => '6bb8447ef66743a0685bf4851db809ffcdbf58c3a28a52c907fb7dfd08ef230209cb84a7e2c6f63f5e1ea12061e9ac20dbf1b68ba2546a38ec5794a10a25c42d'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
ActionController::Base.session_store = :active_record_store
