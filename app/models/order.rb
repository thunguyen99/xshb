class Order < ActiveRecord::Base
  belongs_to :user
  has_many :order_line_items

  before_create :generate_oid

protected
  def generate_oid
    self.oid = "#{Time.now.to_i}#{self.user.id}"
  end

end