require 'rails_helper'

RSpec.describe 'BB home' do
  it 'works' do
    visit '/bb'

    expect(page).to have_content 'Welcome to BooksBunker!'
  end
end
