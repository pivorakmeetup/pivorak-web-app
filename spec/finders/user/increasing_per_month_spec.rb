# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User::IncreasingPerMonth do
  let!(:user)  { create(:user, created_at: Time.current - 1.month) }
  let!(:user2) { create(:user, created_at: Time.current) }
  let!(:user3) { create(:user, created_at: Time.current + 1.month) }

  it 'last should eq sum of all' do
    expect(described_class.call.values.last).to eq 3
  end
end
