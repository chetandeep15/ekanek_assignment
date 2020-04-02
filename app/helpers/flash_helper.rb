module FlashHelper
  FLASH_CLASS = {
    notice: "alert alert-info",
    success: "alert alert-success",
    error: "alert alert-danger",
    alert: "alert alert-warning"
  }

  def flash_class(type)
    FLASH_CLASS[type.to_sym]
  end
end
