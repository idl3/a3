class Admin::BusinessesController < Admin::BaseController
  def index
    @businesses = Business.all
    @approved = Business.where(:approved => true)
    @unapproved = Business.where(:approved => false)
  end

  def new
    @business ||= Business.new
    @pindustries = pri_industries
    @biztypes = biz_types
    @staffno = staff_no
  end

  def create
    @business = Business.new(params[:business])
    if @business.save
      @business.attachments << Attachment.new(:content => params[:logo], :category => "primarylogo")
      if @business.save
        flash[:success] = "Successfully created the new business '#{@business.name}'"
      else
        flash[:success] = "Successfully created the new business '#{@business.name}'"
      end
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
    @pindustries = pri_industries
    @biztypes = biz_types
    @staffno = staff_no
  end

  def update
    @business = Business.find_by_id(params[:id])
    @business.attributes = params[:business]
    if params[:logo]
      attachments = Attachment.where(:attachable_id => @business.id, :attachable_type => "Business", :category => "primarylogo")
      if attachments.count > 0
        attachments.each do |a|
          a.category = "archivelogo"
          a.save
        end
      end
      newlogo = Attachment.new(:content => params[:logo], :category => "primarylogo")
    end
    @business.target = []
    if params[:array]
      params[:array].each_key do |k|
        @business[k] = []
        params[:array][k].try(:each_value) do |e|
          @business[k] << e unless e.blank?
        end
      end
    end
    if params[:add]
      params[:add].each_key do |k|
        params[:add][k].try(:each_value) do |e|
          @business[k] << e unless e.blank?
        end
      end
    end
    if params[:remove]
      if remove = params[:remove]
        remove.each_key do |k|
          puts "Names to Remove: #{remove}"
          if current = @business.send(k)
            new = []
            puts current
            remove.each_value do |r|
              @business.send(k).delete(r) if current.include?(r)
            end
            @business.send(k).compact.reject(&:blank?)
            puts @business.send(k).inspect
          end
        end
      end
    end
    if params[:contact]
      if @business.contact
        @business.contact.attributes = params[:contact]
      else
        @business.contact = Contact.new(params[:contact])
      end
    end
    if @business.save
      if newlogo
        @business.attachments << newlogo
        @business.save
      end
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
    @resp = false
    if @resp = params[:new]
      @type = params[:t]
      @types = @type
      @types = @type + 's' unless @type == "keystaff"
      if (true if Float(@resp) rescue false)
        @url = "#{params[:id] ? edit_admin_business_path : admin_businesses_path}/addfield?t=#{@type}&new=#{@resp.to_i+1}"
        @resp = @resp.to_i+1
      end
    end
    respond_to do |format|
      format.js { }
    end
  end

  private
  def pri_industries
    Array.new(YAML.load_file("config/app/business.yml")["primary_industries"].map{|x,y| [y,x] })
  end

  def biz_types
    Array.new(YAML.load_file("config/app/business.yml")["business_types"].map{|x,y| [y,x] })
  end

  def staff_no
    Array.new(YAML.load_file("config/app/business.yml")["staff_no"].map{|x,y| [y,x] })
  end
end
