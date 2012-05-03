class BusinessesController < ApplicationController

  def businesses
    if params[:s]
      search = "%#{params[:s]}%"
      @businesses = Business.where("name LIKE ? OR uvp LIKE ? OR founders LIKE ? AND approved = 't'", search,search,search).paginate(page: params[:page])
    else
      @businesses = Business.where(approved: true).paginate(page: params[:page])
    end
  end

  def business
    @options = YAML.load_file("config/app/business.yml")
    @types = YAML.load_file("config/app/business.yml")["business_types"]
    @industries = YAML.load_file("config/app/business.yml")["primary_industries"]
    @business = Business.find_by_id(params[:id])
    unless @business.approved?
      flash[:alert] = "Business does not exist"
      redirect_to businesses_path
    end
  end
end
