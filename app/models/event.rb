require 'google/api_client'

class Event
  include ActiveModel::Model
  attr_accessor :title, :starting_at, :ending_at

  def self.upcoming
    events = upcoming_events.map do |evt|
      regex = /FREQ=(?<rule>[^;]+)(;.+(?<interval>[0-9]+))?/
      opts = evt.key?('recurrence') ? evt['recurrence'].join.match(regex) : nil
      next nil if evt['start'].key?('date')
      new(
        starting_at: current_recurral(evt['start']['dateTime'], opts),
        ending_at: current_recurral(evt['end']['dateTime'], opts),
        title: evt['summary']
      )
    end

    events.delete_if(&:blank?).sort_by { |event| event.starting_at }
  end

  def self.upcoming_by_date
    obj = Hash.new { |hsh, key| hsh[key] = [] }

    hsh = upcoming.each_with_object(obj) do |event, events|
      events[event.starting_at.to_date] << event
    end

    Hash[hsh.sort_by { |date, _events| date }]
  end

  def self.client
    client = Google::APIClient.new(application_name: 'The Next Website')
    client.authorization.access_token = TNW::Google.access_token
    client
  end

  def self.upcoming_events
    starting_at = DateTime.now
    ending_at = starting_at.end_of_week

    tnw_calendar_id = Rails.application.secrets.google_calendar_id
    cal = client.discovered_api('calendar', 'v3')
    output = client.execute(api_method: cal.events.list,
                            parameters: {
                              'calendarId' => tnw_calendar_id,
                              'timeMin' => starting_at,
                              'timeMax' => ending_at
                            }
                           )

    JSON.parse(output.response.body)['items']
  end

  def self.current_recurral(date_time, opts)
    date_time = DateTime.parse(date_time)
    return date_time if opts.blank?

    this_week = (Date.today..Date.today + 1.week)
    interval = opts[:interval].blank? ? 1 : opts[:interval].to_i

    loop do
      rule = case opts[:rule]
             when 'WEEKLY' then :week
             end

      return date_time if this_week.include?(date_time.to_date)
      date_time += interval.send(rule)
    end
  end
end
