require 'rails_helper'

RSpec.describe 'Cancel Knock' do
  before { assume_logged_in_user }

  let!(:member) { create :member, user_id: current_user.id, status: :knock }
  let!(:book)   { create :book, member: member, status: :moderation }

  before do
    visit '/bb'
  end

  it 'show description message and form for new book' do
    expect(page).to have_content I18n.t('bb.knock.request_under_review')
    expect(page).to have_link I18n.t('bb.knock.cancel_request')

    click_link I18n.t('bb.knock.cancel_request')

    expect(page).not_to have_content I18n.t('bb.knock.request_under_review')
    expect(page).not_to have_link I18n.t('bb.knock.cancel_request')

    expect(page).to have_content I18n.t('bb.home.you_are_not_member')
    expect(page).to have_link    I18n.t('bb.home.knock_knock')
  end
end
