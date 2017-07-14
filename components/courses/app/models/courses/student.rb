module Courses
  class Student < ApplicationRecord
    has_one :interview
  end
end
