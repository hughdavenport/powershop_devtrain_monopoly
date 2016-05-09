class Event < ActiveRecord::Base
  store :data, coder: JSON
  belongs_to :game
end
