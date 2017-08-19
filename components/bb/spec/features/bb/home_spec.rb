require 'rails_helper'

RSpec.describe 'BB home' do
  before { assume_logged_in_user }

  it 'works' do
    visit '/bb'

    expect(page).to have_content 'Welcome to BooksBunker!'
  end
end
