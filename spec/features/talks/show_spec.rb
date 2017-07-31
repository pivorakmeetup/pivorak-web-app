describe 'Talk SHOW' do
  let(:user) { create :user, first_name: 'John', last_name: 'Doe' }
  let(:talk) { create :talk, speaker_id: user.id }

  before { visit talk_path(talk) }

  it 'displays talk' do
    expect(page).to have_content talk.title
  end

  it 'shows talk speaker full name' do
    expect(talk.speaker.full_name).to eq(user.full_name)
    expect(page).to have_content talk.speaker.full_name
  end
end
