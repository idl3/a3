class Admin::ArticlesController < Admin::BaseController
  def index
    @articles = Article.all
    @published = Article.where(:published => true)
    @unpublished = Article.where(:published => false)
  end

  def new
    @article = Article.new
  end

  def show
    redirect_to edit_admin_article_path(params[:id])
  end

  def create
    article = Article.new(params[:article])
    if article.save
      flash[:success] = "Successfully created article"
      redirect_to admin_articles_path
    else
      flash[:alert] = "There was a problem creating the article"
      redirect_to new_admin_article_path(article)
    end
  end

  def update
    @article = Article.find_by_id(params[:id])
    @article.attributes = params[:article]
    if @article.save
      flash[:success] = "Successfully updated article"
      redirect_to admin_articles_path
    else
      flash[:alert] = "There was a problem updating the article"
      redirect_to edit_admin_article_path(@article)
    end
  end

  def edit
    @categories = {"All" => nil}
    Category.all.each do |c|
      @categories[c.name] = c.id
    end
    unless @article = Article.find_by_id(params[:id])
      flash[:alert] = "Article does not exist"
      redirect_to admin_articles_path
    end
  end

  def publish
    article = Article.find_by_id(params[:id])
    article.published = article.published ? false : true
    msg = article.published ? "publish" : "unpublish"
    if article.save
      flash[:success] = "Successfully #{msg}ed the article '#{article.title}'"
    else
      flash[:alert] = "There was an error trying to #{msg} the article '#{article.title}'"
    end
    redirect_to admin_articles_path
  end

  def destroy
    @article = Article.find_by_id(params[:id])
    if @article.destroy
      flash[:success] = "Sucessfully deleted article '#{@article.title}'"
    else
      flash[:alert] = "There was an error tryng to delete article '#{@article.title}'"
    end
    redirect_to admin_articles_path
  end
end
