require 'date'
require 'json'
require './config'

class Schedule
  @h = {}
  @holidays
  @fileName
  @startDate
  @numOfYear
  @team

  def initialize
    @h = Hash.new
    @holidays = Config.holidays
    @fileName = Config.fileName
    @startDate = Config.startDate
    @numOfYear = Config.numOfYear
    @team = Config.team
  end

  def createSchedule
    # check if schedule created already
    if File.file?(@fileName)
      @h = JSON.parse(File.read(@fileName))
    else
      sDate = @startDate
      counter = 0
      while sDate.year < @startDate.year + @numOfYear do
        if counter > @team.length - 1
          counter = 0
        end
        # skip weekends or holidays
        while (sDate.saturday? || sDate.sunday? || isHoliday(sDate)) do
          sDate += 1
        end

        # check if the sDate over the @numOfYear yet
        if sDate.year >= @startDate.year + @numOfYear then
          break
        end

        @h[sDate.to_s] = @team[counter]
        sDate += 1
        counter += 1
      end
      saveSchedule
    end
  end

  def displaySupportHeroByDate(date)
    return @h[date.to_s]
  end

  def swapSchedule(from, to)
    fromUser = @h[from.to_s]
    toUser = @h[to.to_s]

    if fromUser.to_s == '' || toUser.to_s == ''
      return false
    else
      @h[from.to_s] = toUser
      @h[to.to_s] = fromUser
      saveSchedule
      return true
    end
  end

  def displayMonth(date)
    d = Date.new(date.year, date.month, 1)
    tempHash = Hash.new
    while d.month == date.month do
      if @h.include?(d.to_s)
        tempHash[d.to_s] = @h[d.to_s]
      end
      d+=1
    end
    return tempHash
  end

  def displayUserSchedule(name)
    return @h.select { |k, v| v.to_s.downcase.eql? name.to_s.downcase }
  end

  def undoable(date)
    if (!@h.has_key?(date.to_s))
      return false
    else
      # reschedule the user from the date
      user = @h[date.to_s]
      @h[date.to_s] = ''
      userArr = @h.values
      userArr = userArr.reject { |e| e.to_s.empty? }
      userArr.insert(-1, user)
      counter = 0
      @h.each_pair do |k, v|
        @h[k] = userArr[counter]
        counter+=1
      end
      saveSchedule
      return true
    end
  end

  private
  # save the schedule in file
  def saveSchedule
    aFile = File.new(@fileName, 'w')
    aFile.puts(@h.to_json)
    aFile.close
  end

  def isHoliday(date)
    if @holidays.include?(date.to_s)
      return true
    else
      return false
    end
  end
end

