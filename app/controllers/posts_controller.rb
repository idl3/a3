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
    @article = Article.find(params[:id])
    if @article.nil? or @article.published != true
      redirect_to '/404'
    end
  end

  def articles
    @articles = Article.where(:published => true)
  end

end
