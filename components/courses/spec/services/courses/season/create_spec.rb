# frozen_string_literal: true

require 'rails_helper'

describe Courses::Season::Create do
  let(:season) { build(:season, title: 'Title', start_at: Time.current, finish_at: Time.current + 100.days) }
  let(:user)   { create(:user) }

  describe '#call' do
    it 'creates season with set of default questions' do
      described_class.call(season, user)

      expect(season.questions.count).to eq(5)
      expect(season.mentors.count).to eq(1)
      expect(season.mentors.first.user).to eq user
    end
  end
end
