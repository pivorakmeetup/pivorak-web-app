RSpec.describe 'Supporters LIST' do
  let!(:meetups_group)  { create(:group, slug: 'meetups') }
  let!(:course_group)   { create(:group, slug: 'course') }
  let!(:partners_group) { create(:group, slug: 'info-partners') }

  let!(:meetup_friend)      { create(:friend, :published, group: meetups_group, description: 'Meetup Sponsor') }
  let!(:course_friend)      { create(:friend, :published, group: course_group, description: 'Course Sponsor') }
  let!(:partner_friend)     { create(:friend, :published, group: partners_group, description: 'Partner Sponsor') }
  let!(:unpublished_friend) { create(:friend, group: partners_group, description: 'Unpublished Sponsor') }

  before do
    visit "/supporters"
  end

  it { expect(page).to have_content meetup_friend.description }
  it { expect(page).to have_content course_friend.description }
  it { expect(page).to have_content partner_friend.description }
  it { expect(page).not_to have_content unpublished_friend.description }
end
