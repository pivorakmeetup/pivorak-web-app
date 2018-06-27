require 'rails_helper'

RSpec.describe 'Progress UPDATE' do
  describe 'validations' do
    it { is_expected.to allow_values(::Courses::Progress::ALLOWED_MARKS).for(:homework_mark) }
    it { is_expected.to_not allow_value('20').for(:homework_mark) }
    it { is_expected.to_not allow_value('10').for(:homework_mark) }
    it { is_expected.to_not allow_value('5').for(:homework_mark) }
    it { is_expected.to_not allow_value('-2').for(:homework_mark) }
  end
end
