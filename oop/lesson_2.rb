class Person
  attr_accessor :first_name, :last_name

  def initialize(name)
    name_parts = name.split
    @first_name = name_parts.first
    @last_name = name_parts.size > 1 ? name_parts.last : ''
  end

  def name
    "#{@first_name} #{@last_name}"
  end
end

bob = Person.new('Robert')
puts bob.name
puts bob.first_name
puts bob.last_name
bob.last_name = 'Smith'
puts bob.name