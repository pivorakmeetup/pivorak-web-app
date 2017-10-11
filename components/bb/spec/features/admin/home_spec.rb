require 'rails_helper'

RSpec.describe 'BB home' do
  it 'works' do
    visit '/admin/bb'

    expect(page).to have_content "Welcome to BooksBunker's admin!"
  end
end
