class PanelCategory < ActiveRecord::Base
  has_many :panel_contents

  validates_presence_of :name
end
