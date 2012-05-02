class Admin::BusinessesController < Admin::BaseController
  def index
    @businesses = Business.paginate(page: params[:paginate])
    @approved = Business.where(approved: true).paginate(page: params[:paginate])
    @unapproved = Business.where(approved: false).paginate(page: params[:paginate])
  end

  def new
    @business ||= Business.new
    @pindustries = pri_industries
    @biztypes = biz_types
    @staffno = staff_no
  end

  def create
    @business = Business.new(params[:business])
    @business.build_media
    if params[:array]
      params[:array].each_key do |k|
        if %w(photos videos press).include?(k)
          @business.media[k] = []
        else
          @business[k] = []
        end
        params[:array][k].try(:each_value) do |e|
          if %w(photos videos press).include?(k)
            @business.media[k] << e unless e.blank?
          else
            @business[k] << e unless e.blank?
          end
        end
      end
    end
    if params[:add]
      params[:add].each_key do |k|
        params[:add][k].try(:each_value) do |e|
          if %w(press videos photos).include?(k)
            puts "Adding #{e} into #{k}"
            @business.media[k] << e unless e.blank?
            @business.media.save
          else
            @business[k] << e unless e.blank?
          end
        end
      end
    end
    if params[:contact]
      @business.contact = Contact.new(params[:contact])
    end
    if @business.save
      @business.attachments << Attachment.new(:content => params[:logo], :category => "primarylogo") if params[:logo]
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
    @business.build_media unless @business.media
    @pindustries = pri_industries
    @biztypes = biz_types
    @staffno = staff_no
  end

  def update
    @business = Business.find_by_id(params[:id])
    @business.build_media unless @business.media
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
        if %w(photos videos press).include?(k)
          @business.media[k] = []
        else
          @business[k] = []
        end
        params[:array][k].try(:each_value) do |e|
          if %w(photos videos press).include?(k)
            @business.media[k] << e unless e.blank?
          else
            @business[k] << e unless e.blank?
          end
        end
      end
    end
    if params[:add]
      params[:add].each_key do |k|
        params[:add][k].try(:each_value) do |e|
          if %w(press videos photos).include?(k)
            puts "Adding #{e} into #{k}"
            @business.media[k] << e unless e.blank?
            @business.media.save
          else
            @business[k] << e unless e.blank?
          end
        end
      end
    end
    if params[:remove]
      params[:remove].each_key do |k|
        puts "Names to Remove: #{params[:remove]}"
        if current = @business[k] or current = @business.media[k]
          #current = @business.media[k] if %w(photos videos press).include?(k)
          new = []
          puts current
          params[:remove][k].each_pair do |r,v|
            if %w(photos videos press).include?(k)
              puts "@business.media[#{k}].delete_at(#{r}) invoked"
              puts current.include?(v)
              @business.media[k].delete_at(r.to_i) if current.include?(v)
              @business.media.save
            else
              @business[k].delete_at(r.to_i) if current.include?(v)
            end
          end
          if %w(photos videos press).include?(k)
            @business.media[k].compact.reject(&:blank?)
            puts @business.media[k].inspect
          else
            @business[k].compact.reject(&:blank?)
            puts @business[k].inspect
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
      @types = @type + 's' unless %w(keystaff photos press videos).include?(@type)
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
