class Admin::BusinessesController < Admin::BaseController
  def index
    @businesses = Business.all
    @approved = Business.where(:approved => true)
    @unapproved = Business.where(:approved => false)
  end

  def new
    @business ||= Business.new
  end

  def create
    @business = Business.new(params[:business])
    if @business.save
      flash[:success] = "Successfully created the new business '#{@business.name}'"
      redirect_to admin_businesses_path
    else
      flash[:alert] = "There was an error while trying to create the business '#{@business.name}'"
      redirect_to new_admin_business_path(@business)
    end
  end

  def edit
    unless @business = Business.find_by_id(params[:id])
      flash[:alert] = "Business does not exist"
      redirect_to admin_businesses_path
    end
  end

  def update
    @business = Business.find_by_id(params[:id])
    @business.attributes = params[:business]
    if params[:array]
      if founders = params[:array][:founders]
        @business.founders = []
        founders.each_value do |f|
          @business.founders << f
        end
      end
    end
    if params[:remove]
      if remove = params[:remove][:founders]
        if current = @business.founders
          new = []
          remove.each_value do |r|
            new << r unless current.include?(r)
          end
          @business.founders = new if @business.founders != new
        end
      end
    end
    if @business.save
      flash[:success] = "Successfuly added business '#{@business.name}'"
      redirect_to admin_businesses_path
    else
      flash[:alert] = "There was an error trying to add '#{@business.name}'"
      redirect_to new_admin_business_path(@business)
    end
  end

  def destroy
    @business = Business.find_by_id(params[:id])
    if @business.destroy
      flash[:success] = "Sucessfully deleted business '#{@business.name}'"
    else
      flash[:alert] = "There was an error tryng to delete '#{@business.name}'"
    end
    redirect_to admin_businesses_path
  end

  def approve
    business = Business.find_by_id(params[:id])
    business.approved = business.approved ? false : true
    msg = business.approved ? "publish" : "unpublish"
    if business.save
      flash[:success] = "Successfully #{msg}ed the business #{business.name}"
    else
      flash[:alert] = "There was an error #{msg}ing the business #{business.name}"
    end
    redirect_to admin_businesses_path
  end

  def addfield
    if params[:new]
      @resp = params[:new]
      if (true if Float(@resp) rescue false)
        @url = "#{params[:id] ? edit_admin_business_path : admin_businesses_path}/addfield?new=#{@resp.to_i+1}"
        @resp = @resp.to_i+1
      else
        @resp = false
      end
    else
      @resp = false
    end
    respond_to do |format|
      format.js { }
    end
  end
end
