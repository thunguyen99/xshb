class PanelCategory < ActiveRecord::Base
  acts_as_tree :order => "name"
  has_many :panel_contents

  validates_presence_of :name
end
