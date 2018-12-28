RSpec.describe 'Comings Soon Page' do
  subject { page }

  context 'when comings soon enabled' do
    before do
      visit '/'
    end

    it 'has comings soon text' do
      expect(page).to have_content(I18n.t('coming_soon.cfp_open'))
    end
  end

  context 'when comings soon disabled' do
    before do
      visit '/'
    end

    it 'has comings soon text' do
      expect(page).not_to have_content(I18n.t('coming_soon.cfp_open'))
    end
  end
end
