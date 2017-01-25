describe 'Talk SHOW' do
  let(:talk)  { create :talk }

  before { visit talk_path(talk) }

  it 'displays talk' do
    expect(page).to have_content talk.title
  end
end
