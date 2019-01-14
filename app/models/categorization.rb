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

class Categorization < ApplicationRecord
  belongs_to :category
  belongs_to :item
end
