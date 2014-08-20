Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, '145782966751-sv3m7te3lbkb00gup0c7i8el91l7ic3c.apps.googleusercontent.com',
                           'rUxbUBrvfOBF4tI7OGdUVtF3', {
    scope: 'https://www.googleapis.com/auth/calendar.readonly,email,profile'
  }
end
