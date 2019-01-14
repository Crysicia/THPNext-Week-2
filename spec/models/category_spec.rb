# frozen_string_literal: true

# == Schema Information
#
# Table name: categories
#
#  id          :bigint(8)        not null, primary key
#  name        :string
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'rails_helper'

RSpec.describe Category, type: :model do
  describe 'Model instantiation' do
    subject(:new_category) { described_class.new }

    describe 'Database' do
      it { is_expected.to have_db_column(:id).of_type(:integer) }
      it { is_expected.to have_db_column(:name).of_type(:string) }
      it { is_expected.to have_db_column(:description).of_type(:text) }
      it { is_expected.to have_db_column(:created_at).of_type(:datetime) }
      it { is_expected.to have_db_column(:updated_at).of_type(:datetime) }
    end

    describe 'Validations' do
      it { is_expected.to validate_presence_of :name }
      it { is_expected.to validate_length_of(:name).is_at_least(5).is_at_most(50) }

      it { is_expected.to validate_presence_of :description }
      it { is_expected.to validate_length_of(:description).is_at_least(50).is_at_most(1000) }
    end

    describe 'Associations' do
      it { is_expected.to have_many(:categorizations).dependent(:destroy) }
      it { is_expected.to have_many(:items).through(:categorizations) }
    end
  end
end
