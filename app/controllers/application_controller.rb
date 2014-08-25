class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :logged_in?, :upcoming_events_by_date, :current_week

  def logged_in?
    session.key?(:logged_in)
  end

  def upcoming_events_by_date
    @upcoming_events_by_date ||= Event.upcoming_by_date
  end

  def current_week
    (DateTime.now + 2.days).cweek
  end
end
