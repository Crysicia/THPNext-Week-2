# frozen_string_literal: true

# == Schema Information
#
# Table name: items
#
#  id                  :bigint(8)        not null, primary key
#  original_price      :float            not null
#  has_discount        :boolean          default(FALSE)
#  discount_percentage :integer          default(0)
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  name                :string           default(""), not null
#

require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'Model instantiation' do
    subject(:new_item) { described_class.new }

    describe 'Database' do
      it { is_expected.to have_db_column(:id).of_type(:integer) }
      it { is_expected.to have_db_column(:original_price).of_type(:float).with_options(null: false) }
      it { is_expected.to have_db_column(:has_discount).of_type(:boolean).with_options(default: false) }
      it { is_expected.to have_db_column(:discount_percentage).of_type(:integer).with_options(default: 0) }
      it { is_expected.to have_db_column(:name).of_type(:string).with_options(null: false) }
      it { is_expected.to have_db_column(:created_at).of_type(:datetime).with_options(null: false) }
      it { is_expected.to have_db_column(:updated_at).of_type(:datetime).with_options(null: false) }
    end

    describe 'Validations' do
      it { is_expected.to validate_presence_of :name }
      it { is_expected.to validate_length_of(:name).is_at_least(2).is_at_most(100) }
      it { is_expected.to validate_presence_of :original_price }
      it { is_expected.to validate_presence_of :discount_percentage }
      it { is_expected.to validate_inclusion_of(:discount_percentage).in_range(0..100) }
    end

    describe 'Associations' do
      it { is_expected.to have_many(:categorizations).dependent(:destroy) }
      it { is_expected.to have_many(:categories).through(:categorizations) }
    end
  end

  describe 'Price' do
    context 'when the item has a discount' do
      let(:item) { build(:item_with_discount, original_price: 100.00, discount_percentage: 20) }

      it { expect(item.price).to eq(80.00) }
    end

    context 'when the item doesn\'t have a discount' do
      let(:item) { build(:item_without_discount, original_price: 100.00) }

      it { expect(item.price).to eq(100.00) }
    end
  end

  describe 'Average price' do
    context "when there is one item" do
      let!(:item) { create(:item) }

      it { expect(Item.average_price).to eq(item.price) }
    end

    context "when there is many items" do
      let!(:items) { create_list(:item, rand(3..5)) }
      let(:average_price) { (items.collect(&:price).instance_eval{ reduce(:+) / size }) }

      it { expect(Item.average_price).to eq(average_price) }
    end
  end
end
