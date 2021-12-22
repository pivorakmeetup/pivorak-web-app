# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User::IncreasingPerMonth do
  before do
    create(:user, created_at: Time.current - 1.month)
    create(:user, created_at: Time.current)
    create(:user, created_at: Time.current + 1.month)
  end

  it 'last should eq sum of all' do
    expect(described_class.call.values.last).to eq 3
  end
end
