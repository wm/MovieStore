# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_ms_rails_session',
  :secret      => '86206ec3e2df5753c952f0ae29ca385a99cebcfa70b05d1a3c33b171b05349d2097422e76e5ec2da5eefc82397362f3d1fc1f60c6346b2b78306f568b1996c01'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
