require 'pry'

class Event < ActiveRecord::Base


  def self.future_events
    Event.where("start_time >= ?", Date.today).order("start_time")
  end

  def self.today_events
    Event.where("start_time BETWEEN ? AND ?", Date.today, Time.now.end_of_day).order("start_time")
  end

  def self.week_events
    Event.where("start_time BETWEEN ? AND ?", Date.today, Time.now + 1.weeks).order("start_time")
  end

  def self.month_events
    Event.where("start_time BETWEEN ? AND ?", Date.today, Time.now + 1.month).order("start_time")
  end

  def self.next_day(currently_viewed_day)
    result = Event.where("start_time = ?", currently_viewed_day + 1.day).order("start_time")
  end
end
