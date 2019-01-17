# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                     :bigint(8)        not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Model instantiation' do
    subject(:new_user) { described_class.new }

    describe 'Database' do
      it { is_expected.to have_db_column(:id).of_type(:integer) }
      it { is_expected.to have_db_column(:email).of_type(:string).with_options(null: false, default: '') }
      it { is_expected.to have_db_column(:encrypted_password).of_type(:string).with_options(null: false, default: '') }
      it { is_expected.to have_db_column(:reset_password_token).of_type(:string) }
      it { is_expected.to have_db_column(:reset_password_sent_at).of_type(:datetime) }
      it { is_expected.to have_db_column(:remember_created_at).of_type(:datetime) }
      it { is_expected.to have_db_column(:created_at).of_type(:datetime).with_options(null: false) }
      it { is_expected.to have_db_column(:updated_at).of_type(:datetime).with_options(null: false) }
      it { is_expected.to have_db_column(:confirmation_token).of_type(:string) }
      it { is_expected.to have_db_column(:confirmed_at).of_type(:datetime) }
      it { is_expected.to have_db_column(:confirmation_sent_at).of_type(:datetime) }
    end

    describe 'Validations' do
      # === Presence ===
      it { is_expected.to validate_presence_of :email }
      it { is_expected.to validate_presence_of(:password) }

      # === Length ===
      it { is_expected.to validate_length_of(:password).is_at_least(6) }

      # === Uniqueness ===
      it { is_expected.to validate_uniqueness_of(:email).ignoring_case_sensitivity }
    end
  end
end
