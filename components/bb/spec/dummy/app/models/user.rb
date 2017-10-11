class User < ApplicationRecord
  def self.sorted
    all.sort
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def reverse_full_name
    "#{last_name} #{first_name}"
  end
end
