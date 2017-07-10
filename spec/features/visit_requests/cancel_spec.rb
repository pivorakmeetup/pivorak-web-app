RSpec.describe 'Visit Requests CANCEL' do
  let(:event)          { create(:event) }
  let(:user)           { create(:user)  }
  let!(:visit_request) { create(:visit_request, user: user, event: event) }
  let!(:waiting_visit_request) {
    create(
      :visit_request,
      user: user,
      event: event,
      waiting_list: true
    )
  }

  before do
    assume_logged_in(user)
    visit "/events/#{event.slug}"
  end

  it 'changes visit request status to canceled' do
    expect { click_link 'Cancel attendance'}.to change{ visit_request.reload.status }.to ('canceled')
    expect(page).to have_content I18n.t('visit_requests.messages.canceled')
  end

  it 'changes visit request status from waiting list to approved' do
    expect { click_link 'Cancel attendance'}
      .to change{ waiting_visit_request.reload.status }
      .to('approved')
  end

  it 'changes waiting list count by one' do
    expect { click_link 'Cancel attendance'}
      .to change{ VisitRequest.waiting_list.count }
      .by(-1)
  end
end
