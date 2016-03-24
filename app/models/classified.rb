class Classified < ActiveRecord::Base
  serialize :contact, JSON
  serialize :categories, JSON
end
