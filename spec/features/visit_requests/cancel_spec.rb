RSpec.describe 'Visit Requests CANCEL' do
  let(:event)          { create(:event) }
  let(:user)           { create(:user)  }
  let!(:visit_request) { create(:visit_request, user: user, event: event) }

  before do
    assume_logged_in(user)
    visit "/events/#{event.slug}"
  end

  it 'removes visit request from database' do
    expect { click_link 'Cancel attendance'}.to change{VisitRequest.count}.by(-1)
    expect(page).to have_link 'Attend'
  end
end
