require 'rails_helper'

RSpec.describe Shop::OrderItemService do
  let(:order)       { create(:order) }
  let(:item)        { create(:item) }
  let!(:order_item) { create(:order_item, quantity: 1, order: order, item: item) }

  describe '#increase_quantity!' do
    subject { described_class.new(order_item).increase_quantity! }

    it 'increase order item qty' do
      expect { subject }.to change { order_item.quantity }.from(1).to(2)
    end
  end

  describe '#reduce_quantity!' do
    subject { described_class.new(order_item).reduce_quantity! }

    context 'when > 1' do
      let(:order_item) { create(:order_item, quantity: 3, order: order, item: item) }

      it 'increase order item qty' do
        expect { subject }.to change { order_item.quantity }.from(3).to(2)
      end
    end

    context 'when eq 1' do
      it 'increase order item qty' do
        expect { subject }.to change { Shop::OrderItem.count }.from(1).to(0)
      end
    end
  end
end
