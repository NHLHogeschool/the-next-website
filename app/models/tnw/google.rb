module TNW
  class Google
    include HTTParty
    base_uri 'https://accounts.google.com'

    def self.new_access_token
      options = {
        refresh_token: Rails.application.secrets.google_refresh_token,
        client_id: Rails.application.secrets.google_client_id,
        client_secret: Rails.application.secrets.google_client_secret,
        grant_type: 'refresh_token'
      }

      output = post('/o/oauth2/token', body: options)
      output.parsed_response['access_token']
    end

    def self.update_token!
      redis = Redis.new
      output = redis.set('tnw_google_access_token', new_access_token)
      redis.quit
      output == 'OK' ? true : fail
    end

    def self.access_token
      redis = Redis.new
      access_token = redis.get('tnw_google_access_token')
      redis.quit
      access_token
    end
  end
end
