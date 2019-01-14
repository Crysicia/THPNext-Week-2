# frozen_string_literal: true

# == Schema Information
#
# Table name: categorizations
#
#  id          :bigint(8)        not null, primary key
#  category_id :bigint(8)
#  item_id     :bigint(8)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'rails_helper'

RSpec.describe Categorization, type: :model do
  describe 'Model instantiation' do
    subject(:new_categorization) { described_class.new }

    describe 'Database' do
      it { is_expected.to have_db_column(:id).of_type(:integer) }
      it { is_expected.to have_db_column(:category_id).of_type(:integer) }
      it { is_expected.to have_db_column(:item_id).of_type(:integer) }
      it { is_expected.to have_db_column(:created_at).of_type(:datetime) }
      it { is_expected.to have_db_column(:updated_at).of_type(:datetime) }
    end

    describe 'Associations' do
      it { is_expected.to belong_to(:category) }
      it { is_expected.to belong_to(:item) }
    end
  end
end
