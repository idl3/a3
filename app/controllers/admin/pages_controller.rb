class Admin::PagesController < Admin::BaseController
  layout "admin"
  def index
    @pages = Page.all
    @published = Page.where(:published => true)
    @unpublished = Page.where(:published => false)
  end

  def new
   @page ||= Page.new
  end

  def create
   @page = Page.new(params[:page])
   if @page.save
    flash[:success] = "Successfully created a new page '#{@page.title}'"
    redirect_to admin_pages_path
   else
    flash[:alert] = "An error occurred while creating the new page"
    redirect_to new_admin_page_path(@page)
   end
  end

  def edit
    unless @page = Page.find_by_id(params[:id])
      flash[:alert] = "Page does not exist"
      redirect_to admin_pages_path
    end
  end

  def update
    @page = Page.find_by_id(params[:id])
    @page.attributes = params[:page]
    if @page.save
      flash[:success] = "Successfully edited '#{@page.name}' page"
      redirect_to admin_pages_path
    else
      flash[:alert] = "There were validation errors while trying to create the page '#{@page.name}'"
      redirect_to admin_page_path(@page)
    end
  end

  def destroy
    @page = Page.find_by_id(params[:id])
    if @page.destroy
      flash[:success] = "Sucessfully deleted page '#{@page.title}'"
    else
      flash[:alert] = "There was an error tryng to delete page '#{@business.title}'"
    end
    redirect_to admin_pages_path
  end

  def publish
    page = Page.find_by_id(params[:id])
    page.published = page.published ? false : true
    msg = page.published ? "publish" : "unpublish"
    if page.save
      flash[:success] = "Successfully #{msg}ed the page '#{page.title}'"
    else
      flash[:alert] = "There was an error trying to #{msg} the page '#{page.title}'"
    end
    redirect_to admin_pages_path
  end
end
