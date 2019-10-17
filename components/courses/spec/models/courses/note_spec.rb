# frozen_string_literal: true

RSpec.describe Courses::Note, type: :model do
  it { should belong_to(:notable) }
end
