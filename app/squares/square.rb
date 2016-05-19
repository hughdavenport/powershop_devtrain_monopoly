class Square < ActiveRecord::Base
  store :data, coder: JSON
  validates_presence_of :name
  validates_uniqueness_of :name

  # Only want to create from seeds
  def readonly?
      !new_record?
  end
end
