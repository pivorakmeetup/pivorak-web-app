class User
  def initialize(args)
    @id = args[:id]
    @first_name = args[:first_name]
    @last_name = args[:last_name]
  end

  def self.sorted
    User.new(id: 1, first_name: 'Test', last_name: 'User')
  end

  def self.find(args)
    User.new(id: 1, first_name: 'Test', last_name: 'User')
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def reverse_full_name
    "#{last_name} #{first_name}"
  end

  def to_a
    [self]
  end

  private

  attr_reader :first_name, :last_name
end
