require 'google/api_client'

class Event
  include ActiveModel::Model
  attr_accessor :title, :starting_at, :ending_at

  def self.client
    client = Google::APIClient.new(application_name: 'The Next Website')
    client.authorization.access_token = TNW::Google.access_token
    client
  end

  def self.upcoming_events
    tnw_calendar_id = Rails.application.secrets.google_calendar_id
    cal = client.discovered_api('calendar', 'v3')
    output = client.execute(api_method: cal.events.list,
                            parameters: {
                              'calendarId' => tnw_calendar_id,
                              'timeMin' => DateTime.now,
                              'timeMax' => DateTime.now + 1.week
                            }
                           )
    JSON.parse(output.response.body)['items']
  end

  def self.upcoming
    upcoming_events.map do |evt|
      regex = /^.+=(?<rule>[^;]+);.+(?<interval>[0-9]+)$/
      opts = evt.key?('recurrence') ? evt['recurrence'][1].match(regex) : nil
      new(
        starting_at: current_recurral(evt['start']['dateTime'], opts),
        ending_at: current_recurral(evt['end']['dateTime'], opts),
        title: evt['summary']
      )
    end
  end

  def self.current_recurral(date_time, opts)
    date_time = DateTime.parse(date_time)
    return date_time if opts.blank?

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
