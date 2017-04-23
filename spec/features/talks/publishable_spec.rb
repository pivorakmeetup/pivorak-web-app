RSpec.describe 'Talk publishable' do
  let(:event){ create :event }
  let!(:published_talk)   { create :talk, title: 'Published Talk', event: event }
  let!(:unpublished_talk) { create :talk, title: 'Unpublished Talk', published: false, event: event }

  before { visit '/talks' }

  it 'shows only published talks' do
    expect(page).to     have_content 'Published Talk'
    expect(page).to_not have_content 'Unpublished Talk'
  end
end
