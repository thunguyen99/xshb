class Category < ActiveRecord::Base
  acts_as_tree :order => "name"
  has_many :articles

  validates_presence_of :name
end
