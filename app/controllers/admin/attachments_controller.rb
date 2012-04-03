class Admin::AttachmentsController < Admin::BaseController
  def index
    @attachments = Attachment.all
    @business = Attachment.where(:attachable_type => "Business")
    @person = Attachment.where(:attachable_type => "Person")
    @page = Attachment.where(:attachable_type => "Page")
    @article = Attachment.where(:attachable_type => "Article")
  end

  def new

  end

  def create

  end

  def edit

  end

  def destroy

  end
end
