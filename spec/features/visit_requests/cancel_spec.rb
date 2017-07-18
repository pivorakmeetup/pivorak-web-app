RSpec.describe 'Visit Requests CANCEL' do
  subject              { click_link 'Cancel attendance'}
  let(:event)          { create(:event) }
  let(:user)           { create(:user)  }
  let!(:visit_request) { create(:visit_request, user: user, event: event) }

  before do
    assume_logged_in(user)
    visit "/events/#{event.slug}"
  end

  it 'changes visit request status to canceled' do
    expect { click_link 'Cancel attendance'}.to change{ visit_request.reload.status }.to (VisitRequest::CANCELED.to_s)
    expect(page).to have_content 'Pity.. Hope to see you next time!'
  end

  it 'sends email to admin' do
    click_link 'Cancel attendance'
    active_job = active_jobs[0]
    expect(active_job[:job]).to eq ActionMailer::DeliveryJob
    expect(active_job[:args][0]).to eq 'VisitRequestMailer'
    expect(active_job[:args][1]).to eq 'notify_admin_about_canceled_attendee'
  end
end
