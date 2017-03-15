RSpec.describe 'Not available feature' do
  subject { page }

  before do
    allow(Rails).to receive_message_chain(:env, :production?) { true }
  end

  context 'regular visitor' do
    before { visit goals_path }

    it { is_expected.to have_current_path root_path }
  end

  context 'admin visitor' do
    before do
      assume_admin_logged_in
      visit goals_path # just like an example
    end

    it { is_expected.to have_current_path goals_path }
  end
end
