# frozen_string_literal: true

RSpec.describe 'Events READ' do
  before do
    create(:event, title: 'Test Event A', status: :confirmation)
    create(:event, title: 'Test Event B')

    assume_admin_logged_in(supervisor: true)
    visit '/admin/events'
  end

  it { expect(page).to have_link 'Test Event A' }
  it { expect(page).to have_link 'Test Event B' }
  it { expect(page).to have_link 'New Event' }
  it { expect(page).to have_link('Edit', count: 2) }
  it { expect(page).to have_link('Visitors Report', count: 1) }

  it 'New Event click redirect to #new' do
    click_link 'New Event'
    expect(page).to have_current_path('/admin/events/new')
  end

  context 'when do not paginate less than 10 records on the page' do
    it 'does not have second page' do
      expect(page).not_to have_xpath("//*[@class='ui pagination menu']//a[text()='2']")
    end
  end

  context 'when paginate more than 10 records on the page' do
    before do
      FactoryBot.create_list(:event, 11)
      visit '/admin/events'
    end

    it 'has second page' do
      find(:xpath, "//*[@class='ui pagination menu']//a[text()='2']").click
      expect(page.status_code).to eq(200)
    end
  end
end
