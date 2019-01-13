describe DatePresenter, type: :presenter do
  let(:date) { Date.new(2015,7,1) }
  let(:presenter) { described_class.new(date, view) }

  describe '#day' do
    it { expect(presenter.day).to eq date.strftime('%a') }
  end

  describe '#month' do
    it { expect(presenter.month).to eq date.strftime('%b') }
  end

  describe '#day_of_the_month' do
    it { expect(presenter.day_of_the_month).to eq date.strftime('%d') }
  end

  describe '#hour' do
    it { expect(presenter.hour).to eq date.strftime('%H:%M') }
  end
end