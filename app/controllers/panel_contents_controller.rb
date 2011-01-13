class PanelContentsController < ApplicationController
  before_filter :login_required

  access_control do
    allow :admin
  end

  def index
    @panel_contents = PanelContent.paginate(:all,:per_page=>20,:page => params[:page], :order => 'is_published DESC,weight DESC,created_at DESC')
  end

  def new
    @panel_content = PanelContent.new
  end

  def create
    @panel_content = PanelContent.new(params[:panel_content])
    if @panel_content.save
      redirect_to "/panel_contents"
      flash[:notice] = "#{@panel_content.title}添加成功"
    else
      flash[:error]  = "添加失败，请重新尝试"
      render :action => 'new'
    end
  end

  def edit
    @panel_content = PanelContent.find(params[:id])
  end

  def update
    @panel_content = PanelContent.find(params[:id])
    if @panel_content.update_attributes(params[:panel_content])
      flash[:notice] = "#{@panel_content.title} 修改成功"
      redirect_to "/panel_contents"
    else
      flash[:error] = "#{@panel_content.title} 修改失败"
      render :action => "edit"
    end
  end

  def destroy
    @panel_content = PanelContent.find(params[:id])
    if @panel_content.destroy
      flash[:notice] = "#{@panel_content.title} 删除成功"
    else
      flash[:error] = "发生未知错误，请联系管理员"
    end
    redirect_to "/panel_contents"
  end

end
