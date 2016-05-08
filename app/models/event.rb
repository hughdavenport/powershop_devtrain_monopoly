class Event < ActiveRecord::Base
  store :data, coder: JSON
end
