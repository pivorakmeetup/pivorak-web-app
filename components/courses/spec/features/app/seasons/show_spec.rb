require 'rails_helper'

RSpec.describe 'Season SHOW' do
  context "season with 'registration' status" do
    let!(:season) { create(:season, title: 'Test Season', status: :registration) }

    before { visit 'courses/seasons/test-season' }

    it "expect page to have needed links" do
      expect(page).to have_content 'Test Season'

      expect(page).to have_link 'Register'
      expect(page).not_to have_link 'Send Homework'
      expect(page).not_to have_link 'Pick interview time'
    end
  end

  context "season with 'selection' status" do
    let!(:season) { create(:season, title: 'Test Season', status: :selection) }

    before { visit 'courses/seasons/test-season' }

    it "expect page to have needed links" do
      expect(page).to have_content 'Test Season'

      expect(page).not_to have_link 'Register'
      expect(page).not_to have_link 'Send test task'
      expect(page).not_to have_link 'Send Homework'
      expect(page).not_to have_link 'Pick interview time'
    end
  end

  context "season with 'live' status" do
    let!(:season) { create(:season, title: 'Test Season', status: :live) }

    before { visit 'courses/seasons/test-season' }

    it "expect page to have needed links" do
      expect(page).to have_content 'Test Season'

      expect(page).to have_link 'Send Homework'
      expect(page).not_to have_link 'Register'
      expect(page).not_to have_link 'Send test task'
      expect(page).not_to have_link 'Pick interview time'
    end
  end
end
