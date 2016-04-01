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

  def name=(name)
    name_parts = name.split
    if name_parts.size > 1
      @first_name = name_parts.first
      @last_name = name_parts.last
    elsif name_parts.size == 1
      @first_name = name_parts.first
    else
      puts "Error"
    end
  end
end

bob = Person.new('Robert')
puts bob.name
puts bob.first_name
puts bob.last_name
bob.last_name = 'Smith'
puts bob.name

bob.name = "John"
puts bob.first_name
puts bob.last_name