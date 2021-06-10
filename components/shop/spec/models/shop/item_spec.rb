# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Shop::Item, type: :model do
  describe 'validations' do
    context 'when item valid' do
      subject { build(:item) }

      it 'is valid with valid attributes' do
        expect(subject).to be_valid
      end
    end

    context 'when name missing' do
      subject { build(:item, name: nil) }

      it 'is invalid with valid attributes' do
        expect(subject).to_not be_valid
        # TODO: expect to have concreter errors
      end
    end

    context 'when available_qty missing' do
      subject { build(:item, available_qty: nil) }

      it 'is invalid with valid attributes' do
        expect(subject).to_not be_valid
        # TODO: expect to have concreter errors
      end
    end

    context 'when available_qty price' do
      subject { build(:item, price: nil) }

      it 'is invalid with valid attributes' do
        expect(subject).to_not be_valid
        # TODO: expect to have concreter errors
      end
    end
  end
end
