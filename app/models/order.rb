class Order < ActiveRecord::Base
  belongs_to :user
  has_many :order_line_items

  before_create :generate_oid

  named_scope :in_user, lambda {|user_id|
        {:conditions => ["orders.user_id in (?)", user_id]}
  }

  def show_status
    if self.status == 0
      "<b style='color:red;'>待付款</b>"
    else self.status == 1
      "<b style='color:green;'>已付款</b>"
    end
  end

protected
  def generate_oid
    self.oid = "#{Time.now.to_i}#{self.user.id}"
  end

end