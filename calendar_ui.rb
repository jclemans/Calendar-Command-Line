require 'active_record'
require 'pry'

require './lib/event'

ActiveRecord::Base.establish_connection(YAML::load(File.open('./db/config.yml'))['development'])


def welcome
  puts "Hello, I am your calendar. How can I help you today?"
  main_menu
end

def main_menu
  choice = nil
  until choice == 'x'
    puts "Enter [a] to add a new event."
    puts "      [v] to view all events."
    puts "      [e] to edit an event."
    puts "      [x] to exit."
    choice = gets.chomp
    case choice
    when 'a'
      clear
      add_event
    when 'v'
      clear
      view_events
    when 'e'
      clear
      choose_event
    when 'x'
      clear
      puts "Goodbye human!!!"
      exit
    else
      puts "I don't understand that command. Try again!"
    end
  end
end

# EVENT METHODS ------------------

def add_event
  puts "Please describe the event:"
  description = gets.chomp.capitalize
  puts "Enter location of the event:"
  location = gets.chomp.capitalize
  puts "Enter the start date and time (yy-mm-dd hh:mm):"
  start_time = gets.chomp
  puts "Enter the end date and time (yy-mm-dd hh:mm):"
  end_time = gets.chomp
  new_event = Event.create({description: description, location: location, start_time: start_time, end_time: end_time})
  puts "'#{description} at #{location} on #{start_time}' has been added."
  puts "Do you want to add another event?"
end

def choose_event
  puts "Which event do you want to edit?"
  view_events
  choice = gets.chomp
  chosen = Event.where({description: choice}).first
  puts "What now??"
  puts "Enter [d] to delete the event or [e] to edit it."
  selection = gets.chomp
  case selection
  when 'd'
    delete_event(chosen)
  when 'e'
    edit_event(chosen)
  when 'm'
    main_menu
  else
    puts "I don't understand that command. Try again!"
  end
end

def edit_event(chosen)
  puts "What do you want to change?"
  # binding.pry
  puts "Edit - [d]escription, [l]ocation, [s]tart time, or [e]nd time?"
  choice = gets.chomp
  case choice
  when 'd'
    puts "Enter new description:"
    new_desc = gets.chomp
    chosen.update({description: new_desc})
  when 'l'
    puts "Enter a new location:"
    new_loc = gets.chomp
    chosen.update({location: new_loc})
  when 's'
    puts "Enter a new start date and time (yy-mm-dd hh:mm):"
    new_start = gets.chomp
    chosen.update({start_time: new_start})
  when 'e'
    puts "Enter a new start date and time (yy-mm-dd hh:mm):"
    new_end = gets.chomp
    chosen.update({end_time: new_end})
  else
    puts "I don't understand that command. Try again!"
  end
end

def delete_event(chosen)
  chosen.destroy
  puts "'#{chosen.description}' has been eradicated from your timeline."
end

def view_events
  puts "Here is a list of all your events so far:"
  Event.future_events.each {|event| puts event.description + " @ " + event.start_time.to_s}
end


# OTHER STUFF ------------------

def clear
  system "clear && printf '\e[3J'"
end
clear
welcome
