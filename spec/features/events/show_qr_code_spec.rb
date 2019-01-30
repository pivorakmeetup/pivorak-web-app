describe 'show QR code' do
  let(:user)  { create(:user, first_name: 'Attendee') }
  let(:qr_code_id) { '#pk-qr-code__main' }
  let(:button_translation) { I18n.t('events.qr_code.show_button') }

  shared_examples 'no_qr_code' do
    it 'does not render qr code' do
      expect(page).not_to have_css(qr_code_id)
    end
  end

  describe 'live event' do
    let(:event) { create(:event_with_talks, :live_now) }

    context 'user approved' do

      before do
        assume_logged_in(user)

        create(:visit_request, :approved, event: event, user: user)
        visit "/events/#{event.slug}"
      end

      it 'toggles visibility of qr code' do
        click_on button_translation
        expect(page).to have_css(qr_code_id)

        click_on button_translation
        expect(page).not_to have_css(qr_code_id, visible: :hidden)
      end
    end

    context 'user not allowed' do
      context 'pending' do
        before do
          assume_logged_in(user)

          create(:visit_request, :pending, event: event, user: user)
          visit "/events/#{event.slug}"
        end

        it_behaves_like 'no_qr_code'
      end

      context 'canceled' do
        before do
          assume_logged_in(user)

          create(:visit_request, :canceled, event: event, user: user)
          visit "/events/#{event.slug}"
        end

        it_behaves_like 'no_qr_code'
      end

      context 'visited' do
        before do
          assume_logged_in(user)

          create(:visit_request, :final, event: event, user: user)
          visit "/events/#{event.slug}"
        end

        it_behaves_like 'no_qr_code'
      end
    end
  end

  describe 'not live event' do
    let!(:event) { create(:event_with_talks) }

    before do
      assume_logged_in(user)

      create(:visit_request, :approved, event: event, user: user)
      visit "/events/#{event.slug}"
    end

    it_behaves_like 'no_qr_code'
  end
end