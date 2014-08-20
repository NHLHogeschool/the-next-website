require 'google/api_client'

class Event
  def self.upcoming
    access_token = Rails.application.secrets.google_access_token
    tnw_calendar_id = Rails.application.secrets.google_calendar_id

    client = Google::APIClient.new(application_name: 'The Next Website')
    client.authorization.access_token = access_token

    cal = client.discovered_api('calendar', 'v3')
    output = client.execute(api_method: cal.events.list,
                            parameters: {
                              'calendarId' => tnw_calendar_id,
                              'timeMin' => DateTime.now,
                              'timeMax' => DateTime.now + 1.week
                            }
                           )
    json = JSON.parse(output.response.body)
    json['items']
  end
end
