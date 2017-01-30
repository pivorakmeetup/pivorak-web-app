RSpec.describe 'Visit Requests APPROVE' do
  let(:not_passed_event) { create(:event) }
  let(:passed_event)     { create(:event, status: :passed) }
  let(:user_a)           { create(:user, first_name: 'A', last_name: 'User') }
  let(:user_b)           { create(:user, first_name: 'B', last_name: 'User') }
  let(:user_c)           { create(:user, first_name: 'C', last_name: 'User') }
  let(:emails_list)      { [user_a, user_b].map(&:email).join(', ') + ', fake@user.com' }

  before { assume_admin_logged_in }

  context 'visit not passed event visit requests' do
    before { visit admin_event_visit_requests_path(not_passed_event) }

    it { expect(page).to_not have_content 'Import' }
  end

  context 'visit passed event visit requests' do
    before { visit admin_event_visit_requests_path(passed_event) }

    it { expect(page).to have_content 'Import' }
    it 'import visit requests of users' do
      fill_in 'Emails list', with: emails_list
      click_button 'Import'

      expect(page).to have_current_path(admin_event_visit_requests_path(passed_event))
      expect(page).to have_link user_a.full_name
      expect(page).to have_link user_b.full_name
      expect(page).to_not have_link user_c.full_name
    end
  end
end
