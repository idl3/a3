class BusinessesController < ApplicationController
  INDUSTRIES = [
    "All",
    "Advertising",
    "Bio Technology",
    "Clean Tech",
    "Consumer Devices",
    "Consumer Web",
    "eCommerce",
    "Education",
    "Enterprise",
    "Games",
    "Video",
    "Entertainment",
    "Legal",
    "Mobile",
    "Wireless",
    "Hosting",
    "Consulting",
    "Communication",
    "Search",
    "Security",
    "Semiconductor",
    "Software",
    "Other"
  ]
  REQUISITES = [
    "All",
    "Funding",
    "Co-Founders",
    "Talent",
    "Technology",
    "Network",
    "Merger & Acquisition",
    "Joint Ventures",
    "Mentorship"
  ]

  def businesses
    if params[:s]
      @businesses = Business.find(:all, :conditions => ["name LIKE ? OR uvp LIKE ? AND approved = 't'", "%#{params[:s]}%", "%#{params[:s]}%"])
    else
      @businesses = Business.where(:approved => true).all
    end
    @industries = INDUSTRIES
    @requisites = REQUISITES
  end

  def business
    @business = Business.where(:approved => true, :id => params[:id])
    if @business.empty?
      flash[:alert] = "Business does not exist"
      redirect_to businesses_path
    end
  end
end
