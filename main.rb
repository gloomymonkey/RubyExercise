#!/usr/bin/env ruby

require 'date'
require './schedule'

s = Schedule.new
# Create schedule
s.createSchedule
puts 'Support Hero Team Schedule 2015'
puts "Enter 'Today' to display today's Support Hero."
puts "Enter 'User <name>' (e.g. User Boris) to display user's schedule."
puts "Enter 'Current' to display full schedule for all users in the current month."
puts "Enter 'Mark <date>' (e.g. Mark 2015-4-1) to mark one of their days on duty as undoable."
puts "Enter 'Swap <fromDate> <toDate>' (e.g. Swap 2015-4-1 2015-5-1) to swap user's duty."
puts "Enter 'Exit' to end the program.\n\n"
while true
  STDOUT.flush
  input = gets.chomp.split(' ')
  # puts(input[0])
  case input[0].to_s.downcase
    when 'today'
      print("Today's Support Hero: " + s.displaySupportHeroByDate(Date.today))
    when 'user'
      print("#{input[1]} schedule: ")
      print(s.displayUserSchedule(input[1]).keys)
    when 'current'
      puts('Full schedule in current month:')
      s.displayMonth(Date.today).each do |key, value|
        print("#{value}(#{key}) ")
      end
    when 'mark'
      begin
        date = Date.parse(input[1])
        user = s.displaySupportHeroByDate(date)
        if s.undoable(date)
          print("Marked #{user}(#{date}) as undoable.")
        else
          print("#{date} is either a holiday or saturday/sunday or out of schedule range.")
        end
      rescue
        print("#{input[1]} is an invalid date.")
      end
    when 'swap'
      if input.size < 3
        print('Invalid input.')
      else
        begin
          fromDate = Date.parse(input[1])
          toDate = Date.parse(input[2])

          if fromDate.to_s == toDate.to_s
            print("#{fromDate} is same as #{toDate}, no swap.")
          else
            fromUser = s.displaySupportHeroByDate(fromDate)
            toUser = s.displaySupportHeroByDate(toDate)

            if s.swapSchedule(fromDate, toDate)
              print("#{fromUser}(#{fromDate}) is swapped with #{toUser}(#{toDate}).")
            else
              print("#{fromDate} or #{toDate} is either a holiday or saturday/sunday or out of schedule range.")
            end
          end
        rescue
          print("#{input[1]} or #{input[2]} is an invalid date.")
        end
      end
    when 'exit'
      print('Exit the program...')
      break
    else
      print("Your input #{input.join(' ')} is not on the commands.")
  end
  puts("\n\n")
end