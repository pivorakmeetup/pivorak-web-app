# frozen_string_literal: true

RSpec.describe 'Page READ' do
  let(:app_page) { create(:page) }

  context 'open existing page' do
    before { visit "/#{app_page.url}" }

    it { expect(page).to have_content(app_page.title) }
    it { expect(page).to have_content(app_page.body) }
  end

  context 'open non existing page' do
    it 'responds with 404 page' do
      visit "/#{Faker::Lorem.word}"
      expect(page.body).to include("The page you were looking for doesn't exist")
    end
  end
end
