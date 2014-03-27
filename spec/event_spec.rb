require 'spec_helper'

describe Event do
  describe '.future_events' do
    it 'lists all the events that will occur from today forward in order' do
      test_event1 = Event.create({description: 'feed the lions', start_time: '2014-04-28 12:00'})
      test_event2 = Event.create({description: 'walk the dog', start_time: '2014-03-28 12:00'})
      test_event3 = Event.create({description: 'wash the lambs', start_time: '2014-09-28 01:13'})
      test_event4 = Event.create({description: 'tickle the pig', start_time: '2015-06-18 09:20'})

      Event.future_events[0].should eq test_event2
    end
  end

  describe '.today_events' do
    it 'lists all the events that are happening today' do
      test_event1 = Event.create({description: 'feed the lions', start_time: '2014-03-27 12:00'})
      test_event2 = Event.create({description: 'walk the dog', start_time: '2014-03-28 14:00'})
      test_event3 = Event.create({description: 'wash the lambs', start_time: '2014-09-28 01:13'})
      Event.all.today_events.should eq [test_event1]
    end
  end

  describe '.week_events' do
    it 'lists all the events for the current week' do
      test_event2 = Event.create({description: 'walk the dog', start_time: '2014-03-29 14:00'})
       test_event1 = Event.create({description: 'feed the lions', start_time: '2014-03-27 12:00'})
      test_event3 = Event.create({description: 'wash the lambs', start_time: '2014-09-28 01:13'})
      Event.all.week_events.should eq [test_event1, test_event2]
    end
  end

  describe '.month_events' do
    it 'lists all the events for the current month' do
      test_event2 = Event.create({description: 'walk the dog', start_time: '2014-03-29 14:00'})
       test_event1 = Event.create({description: 'feed the lions', start_time: '2014-04-20 12:00'})
      test_event3 = Event.create({description: 'wash the lambs', start_time: '2014-09-28 01:13'})
      Event.all.month_events.should eq [test_event2, test_event1]
    end
  end

  describe '.next_day' do
    it 'displays the events for the next day' do
      today_event = Event.create({description: 'walk the dog', start_time: '2014-03-27 14:00'})
      tomorrow_event = Event.create({description: 'feed the lions', start_time: Date.today + 1.day})
      test_event3 = Event.create({description: 'wash the lambs', start_time: '2014-09-28 01:13'})
      Event.next_day(Date.today).first.should eq tomorrow_event
    end
  end
end















