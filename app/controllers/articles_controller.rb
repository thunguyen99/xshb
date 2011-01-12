class ArticlesController < ApplicationController
  before_filter :login_required

  access_control do
    allow :admin
  end

  def index
    @articles = Article.paginate(:all,:per_page=>20,:page => params[:page], :order => 'created_at DESC')
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(params[:article])
    if @article.save
      redirect_to "/articles"
      flash[:notice] = "文章#{@article.title}添加成功"
    else
      flash[:error]  = "添加失败，请重新尝试"
      render :action => 'new'
    end
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
    if @article.update_attributes(params[:article])
      flash[:notice] = "#{@article.title} 修改成功"
      redirect_to "/articles"
    else
      flash[:error] = "#{@article.title} 修改失败"
      render :action => "edit"
    end
  end

  def destroy
    @article = Article.find(params[:id])
    if @article.destroy
      flash[:notice] = "#{@article.title} 删除成功"
    else
      flash[:error] = "发生未知错误，请联系管理员"
    end
    redirect_to "/articles"
  end
end
