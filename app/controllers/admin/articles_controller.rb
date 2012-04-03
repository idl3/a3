class Admin::ArticlesController < Admin::BaseController
  def index
    @articles = Article.all
    @published = Article.where(:published => true)
    @unpublished = Article.where(:published => false)
  end

  def new
    @article = Article.new
  end

  def create

  end

  def edit

  end

  def destroy

  end
end
