require 'rails_helper'

RSpec.describe 'Works' do
  it { expect(true).to eq(true) }

  it 'works' do
    visit '/admin/courses'
  end
end
