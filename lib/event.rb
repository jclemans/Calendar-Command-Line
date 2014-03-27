class Event < ActiveRecord::Base

  def self.future_events
    Event.where("start_time >= ?", Time.now).order("start_time")
  end

end
