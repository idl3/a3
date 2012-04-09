class PostsController < ApplicationController

  def index
    @page = Page.find_by_name("home")
    render :layout => "index"
  end

  def page
    @page = Page.find_by_name(params[:name])
    puts @page.inspect
    if @page.nil? or @page.published != true
      redirect_to '/404'
    end
  end

  def article
    @article = Article.find_by_name(params[:id])
    if @article.nil? or @article.published != true
      redirect_to '/404'
    end
  end

  def articles
    @articles = Article.where(:published => true)
  end

  def categories
    @categories = Category.all
  end

  def category
    unless @category = Category.find_by_slug(params[:name])
      flash[:alert] = "Category '#{params[:name]}' does not exist"
      redirect_to categories_path
    end
  end

end
