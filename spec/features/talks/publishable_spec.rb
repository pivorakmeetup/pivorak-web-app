# TODO VS -> Uncomment after merge https://github.com/pivorakmeetup/pivorak-web-app/pull/117
#
# RSpec.describe 'Talk publishable' do
#   let!(:published_talk)   { create :talk, title: 'Published Talk',   published: true }
#   let!(:unpublished_talk) { create :talk, title: 'Unpublished Talk', published: false }
#
#   before { visit '/talks' }
#
#   it 'shows only published talks' do
#     expect(page).to     have_content 'Published Talk'
#     expect(page).to_not have_content 'Unpublished Talk'
#   end
# end
