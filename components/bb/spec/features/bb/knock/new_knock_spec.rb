require 'rails_helper'

RSpec.describe 'Knock new' do
  before do
    assume_logged_in_user
    visit '/bb/knock/new'
  end

  it 'show description message and form for new book' do
    expect(page).to have_content I18n.t('bb.knock.description')

    fill_in 'Title',       with: 'New super book'
    fill_in 'Description', with: 'Please, let me in'
    click_button I18n.t('bb.knock.submit')

    expect(page).to have_current_path('/bb')
    expect(page).to have_content I18n.t('bb.knock.request_under_review')
  end
end
