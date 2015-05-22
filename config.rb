class Config
  # add more holidays for future schedule
  @@holidays = [Date.new(2015, 1, 1).to_s, Date.new(2015, 1, 19).to_s, Date.new(2015, 2, 16).to_s,
                Date.new(2015, 3, 31).to_s, Date.new(2015, 5, 25).to_s, Date.new(2015, 7, 3).to_s,
                Date.new(2015, 9, 7).to_s, Date.new(2015, 11, 11).to_s, Date.new(2015, 11, 26).to_s,
                Date.new(2015, 11, 27).to_s, Date.new(2015, 12, 25).to_s]

  # number of year to generate schedule
  @@numOfYear = 1

  @@startDate = Date.new(Date.today.year, 1, 1)

  @@team = %w(Sherry Boris Vicente Matte Jack Sherry Matte Kevin Kevin Vicente Zoe Kevin Matte
      Zoe Jay Boris Eadon Sherry Franky Sherry Matte Franky Franky Kevin Boris Franky
      Vicente Luis Eadon Boris Kevin Matte Jay James Kevin Sherry Sherry Jack Sherry Jack)

  @@fileName = 'scheduleDB.txt'

  def self.holidays
    return @@holidays
  end

  def self.numOfYear
    return @@numOfYear
  end

  def self.startDate
    return @@startDate
  end

  def self.team
    return @@team
  end

  def Config.fileName
    return @@fileName
  end
end