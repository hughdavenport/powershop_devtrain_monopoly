class Card < ActiveRecord::Base
  store :data, coder: JSON
  validates_presence_of :name

  enum card_type: [:community_chest, :chance]
  validates_presence_of :card_type

  validates_uniqueness_of :name, scope: :card_type

  # Only want to create from seeds
  def readonly?
    !new_record?
  end
end
