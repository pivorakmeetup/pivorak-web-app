RSpec.describe 'Become a speaker features' do
  context 'when user is logged in' do
    let(:user) { create(:user) }

    before do
      assume_logged_in(user)
      visit '/members'
    end

    it "contains user name in input" do
      expect(find_field('name').value).to eq(user.first_name)
    end

    it "contains user email in input" do
      expect(find_field('email').value).to eq(user.email)
    end
  end

  context 'when user is logged out' do
    before do
      visit '/members'
    end

    it "contains blank name input" do
      expect(find_field('name').value).to eq(nil)
    end

    it "contains blank email input" do
      expect(find_field('email').value).to eq(nil)
    end
  end

  let(:name) { 'fake name' }
  let(:email) { 'fake@mail.com' }
  let(:text) { Faker::Lorem.paragraph }

  context 'when params are valid' do
    before do
      visit '/members'
    end

    it 'sends email' do
      fill_in 'name',  with: name
      fill_in 'email',  with: email
      fill_in 'text',  with: text
      click_button 'Send'

      active_job = ActiveJob::Base.queue_adapter.enqueued_jobs[0]
      expect(active_job[:job]).to eq ActionMailer::DeliveryJob
      expect(active_job[:args][0]).to eq 'NotifyMailer'
      expect(active_job[:args][1]).to eq 'become_speaker'

      expect(page).to have_content "Letter was sended"
    end
  end
end
