# frozen_string_literal: true

RSpec.describe Courses::Student, type: :model do
  it { should have_many(:notes) }
end
