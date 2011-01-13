class PanelContent < ActiveRecord::Base
  belongs_to :panel_category

  validates_presence_of :title,:panel_category_id

  named_scope :published, :conditions => ["is_published=1"]

  named_scope :in_category_name, lambda { |category_name|
    { :include=> [:panel_category],:conditions => ["panel_categories.name = ?", category_name] }
  }

  has_attached_file :uploaded_data,
                    :default_url => "",
                    :url => "/images/assets/:attachment/:id/:style/:filename",
                    :path => ":rails_root/public/images/assets/:attachment/:id/:style/:filename"
  # validates_attachment_presence :uploaded_data,:message => "请选择上传文件"
  validates_attachment_content_type :uploaded_data,
    :content_type => ['image/jpg', 'image/jpeg', 'image/pjpeg', 'image/gif', 'image/png', 'image/x-png'],
    :message => "上传格式不符"
  validates_attachment_size :uploaded_data,
    :less_than => 5.megabyte, #another option is :greater_than
    :message => "上传文件小于5M"

  def show_status
    if self.is_published
      "<img src='/images/published.gif' />"
    else
      "<img src='/images/draft.gif' />"
    end
  end

  def self.list_contents(category,limit=nil)
    self.in_category_name(category).published.all(:order=>"weight DESC")
  end

end
