Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2,
           Rails.application.secrets.google_client_id,
           Rails.application.secrets.google_client_secret,
           access_type: 'offline',
           scope: 'https://www.googleapis.com/auth/calendar.readonly,email,profile',
           prompt: 'select_account consent'
end
