describe 'Talks tags' do
  let!(:talk_about_ruby)  { create :talk, title: 'Ruby Way', tag_list: 'ruby' }
  let!(:talk_about_js)    { create :talk, title: 'JS Way',   tag_list: 'javascript' }
  let!(:talk_about_rails) { create :talk, title: 'Rails Way', tag_list: 'ruby, rails' }

  before { visit '/talks' }

  it 'shows tags links' do
    expect(page).to have_link 'All',        count: 1
    expect(page).to have_link 'ruby',       count: 1
    expect(page).to have_link 'rails',      count: 1
    expect(page).to have_link 'javascript', count: 1
  end

  it 'filter by ruby tags' do
    click_link 'ruby'

    expect(page).to     have_content 'Ruby Way'
    expect(page).to     have_content 'Rails Way'
    expect(page).to_not have_content 'JS Way'
  end

  it 'filter by rails tags' do
    click_link 'rails'

    expect(page).to     have_content 'Rails Way'
    expect(page).to_not have_content 'Ruby Way'
    expect(page).to_not have_content 'JS Way'
  end

  it 'filter by ruby tags' do
    click_link 'javascript'

    expect(page).to     have_content 'JS Way'
    expect(page).to_not have_content 'Ruby Way'
    expect(page).to_not have_content 'Rails Way'
  end
end
