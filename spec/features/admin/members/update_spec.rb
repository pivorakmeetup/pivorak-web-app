# frozen_string_literal: true

RSpec.describe 'Members UPDATE' do
  let!(:member) { create(:user, email: 'tester@example.com') }

  before do
    assume_admin_logged_in(supervisor: true)
    visit "/admin/members/#{member.id}/edit"
  end

  context 'invalid input' do
    it 'validates title presence' do
      fill_in 'Email', with: ''
      click_button 'Update User'

      expect_an_error member_email: :blank
      expect_error_flash_message 'Member', 'updated'
    end
  end

  context 'valid input' do
    it 'create new user' do
      fill_in 'Email', with: 'another@example.com'
      click_button 'Update User'

      expect(page).to have_current_path "/admin/members/#{member.slug}/edit"
      expect_success_flash_message 'Member', 'updated'
    end

    it 'updates user to admin' do
      check 'member_admin'
      click_button 'Update User'

      expect(member.reload.admin).to be_truthy
    end
  end
end
