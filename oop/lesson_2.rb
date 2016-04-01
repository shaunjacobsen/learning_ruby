class Person
  attr_accessor :first_name, :last_name

  def initialize(name)
    parse_full_name(name)
  end

  def name
    "#{@first_name} #{@last_name}"
  end

  def name=(name)
    parse_full_name(name)
  end

  private

  def parse_full_name(name)
    name_parts = name.split
    self.first_name = name_parts.first
    self.last_name = name_parts.size > 1 ? name_parts.last : ''
  end
end

bob = Person.new('Robert Smith')
rob = Person.new('Robert Smith')
if bob.name == rob.name
  puts "Yes"
else
  puts "No"
end