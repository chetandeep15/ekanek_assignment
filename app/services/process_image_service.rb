class ProcessImageService

  attr_reader :current_user, :params, :base_64_image_data, :image_with_mime_type
  def initialize(current_user, params)
    @current_user = current_user
    @params = params
  end

  def process_image
    @base_64_image_data = params.delete(:upload)
    if is_valid_file_type?
      attachment = current_user.attachments.new(params)
      attachment.upload.attach(io: decoded_image, filename: "#{SecureRandom.uuid}.png")
      attachment.save!
      true
    else
      false
    end
  end

  private
    def is_valid_file_type?
      @image_with_mime_type = base_64_image_data.match(/\Adata:([-\w]+\/[-\w\+\.]+)?;base64,(.*)/) || []
      if image_with_mime_type[1] == 'image/png'
        true
      else
        false
      end
    end

    def decoded_image
      decoded_image = Base64.decode64(image_with_mime_type[2])
      StringIO.new(decoded_image)
    end
end