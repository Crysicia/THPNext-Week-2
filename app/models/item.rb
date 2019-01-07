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
#

class Item < ApplicationRecord
  before_save :set_discount_bool
  
  def price
    return original_price unless has_discount

    original_price - (original_price / 100 * discount_percentage)
  end

  def self.average_price
    Item.all.collect(&:price).instance_eval{ reduce(:+) / size }
  end
  
  private
  
  def set_discount_bool
    self.has_discount = self.discount_percentage == 0 ? false : true
  end
end
