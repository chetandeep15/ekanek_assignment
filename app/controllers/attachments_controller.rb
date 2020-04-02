class AttachmentsController < ApplicationController

  before_action :find_attachment_with_link_code, only: :show
  before_action :find_attachment, only: :destroy
  skip_before_action :authenticate_user!, only: :show

  def index
    @attachments = current_user.attachments
  end

  def new
    @attachment = Attachment.new
  end

  def create
    @attachment = current_user.attachments.create(attachment_create_params)

    if @attachment.errors.any?
      flash[:error] = @attachment.errors.full_messages.join("<br>")
      render :new
    else
      flash[:success] = "Attachment Created successfully"
      redirect_to attachments_path
    end
  end

  def show
  end

  def destroy
    if @attachment.destroy
      flash[:success] = "Attachment Deleted successfully"
      redirect_to attachments_path
    else
      flash[:error] = @attachment.errors.full_messages.join("<br>")
      redirect_to attachments_path
    end
  end

  private
  def find_attachment_with_link_code
    link_code = LinkCode.find_by(code: params[:code])
    @attachment = link_code.linkable
    attachment_not_found
  end

  def find_attachment
    @attachment = current_user.attachments.find(params[:id])
    attachment_not_found
  end

  def attachment_create_params
    params.require(:attachment).permit(:title, :description, :upload)
  end

  def attachment_not_found
    unless @attachment.present?
      flash[:error] = "Attachment not found"
      redirect_to attachments_path
    end
  end
end