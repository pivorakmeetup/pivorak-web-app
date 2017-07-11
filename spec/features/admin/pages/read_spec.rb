RSpec.describe 'Page READ' do
  let(:app_page) { create(:page) }

  context 'open existing page' do
    before { visit "/#{app_page.url}" }

    it { expect(page).to have_content(app_page.title) }
    it { expect(page).to have_content(app_page.body) }
  end

  context 'open non existing page' do
    it { expect { visit "/#{Faker::Lorem.word}" }.to raise_error ActionController::RoutingError }
  end
end
