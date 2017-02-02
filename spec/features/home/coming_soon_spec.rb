RSpec.describe 'Coming Soon' do
  subject { page }

  before do
    allow(Rails).to receive_message_chain(:env, :production?) { true }
    visit root_path
  end

  context 'regular visitor' do
    it { is_expected.to have_current_path '/coming-soon' }

    %w[events talks members chat].each do |path|
      it "visit /#{path} redirects to /coming-soon path" do
        visit "/#{path}"

        is_expected.to have_current_path '/coming-soon'
      end
    end

    it 'redirects to login for /admin' do
      visit '/admin'
      is_expected.to have_current_path '/users/sign_in'
    end
  end

  context 'admin visitor' do
    before { assume_admin_logged_in }

    %w[events talks members chat admin].each do |path|
      it "visit /#{path} redirects to /#{path}" do
        visit "/#{path}"

        is_expected.to have_current_path "/#{path}"
      end
    end
  end
end
