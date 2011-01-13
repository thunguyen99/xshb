class Article < ActiveRecord::Base
  belongs_to :category

  validates_presence_of :title,:category_id

  def show_status
    if self.is_published
      "<img src='/images/published.gif' />"
    else
      "<img src='/images/draft.gif' />"
    end
  end
end
