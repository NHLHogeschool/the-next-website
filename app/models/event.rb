require 'google/api_client'

class Event
  def self.upcoming_events
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

  def self.upcoming
    upcoming_events.map do |evt|
      regex = /^.+=(?<rule>[^;]+);.+(?<interval>[0-9]+)$/
      opts = evt['recurrence'][1].match(regex)
      starting_at = DateTime.parse(evt['start']['dateTime'])
      ending_at = DateTime.parse(evt['end']['dateTime'])
      {
        starting_at: current_recurral(starting_at, opts),
        ending_at: current_recurral(ending_at, opts),
        title: evt['summary'],
        location: evt['location']
      }
    end
  end

  def self.current_recurral(date_time, opts)
    range = (DateTime.now..DateTime.now + 1.week).map(&:to_date)

    loop do
      rule  = case opts[:rule]
              when 'WEEKLY' then :week
              end

      date_time += opts[:interval].to_i.send(rule)
      return date_time if range.include?(date_time.to_date)
    end
  end
end
