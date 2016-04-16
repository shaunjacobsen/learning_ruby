class School
  attr_accessor :name, :grade, :roster

  def initialize
    @roster = {}
  end

  def add(name, grade)
    @name = name
    @grade = grade
    if roster[grade].nil?
      roster[grade] = [name]
    else
      roster[grade].push(name)
    end
  end

  def to_h
    key_sorted_roster = roster.sort.to_h
    value_sorted_roster = key_sorted_roster.each do |grade, students|
      students.sort!
    end
    value_sorted_roster
  end

  def grade(grade)
    roster[grade] == nil ? [] : roster[grade]
  end

end

skewl = School.new
shaun = skewl.add("Shaun", 12)
rodney = skewl.add("Rodney", 12)
p skewl.roster

# roster should be like:
# {1: ['John', 'Ashley', etc...], 2: ['William', 'Laure', etc...]}