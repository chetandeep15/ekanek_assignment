var AttachmentFormHelper = function (selectors) {
  this.fileInput = $(selectors.fileInput);
  this.attachmentForm = $(selectors.attachmentForm)
};

AttachmentFormHelper.prototype.init = function() {
  this.formHandler();
}

AttachmentFormHelper.prototype.formHandler = function() {
  var _this = this;
  this.attachmentForm.on('submit', function(e) {
    e.preventDefault(); // stops default behavior
    e.stopPropagation();
    var form_data = _this.attachmentForm.serializeArray();
    var image_base64 = "";
    var file = _this.fileInput[0].files[0];
    var reader = new FileReader();
    reader.onload = function(e){
      image_base64 = e.target.result;
      form_data.push({'name': "attachment[upload]", 'value': image_base64});
      $.ajax({
        method: "POST",
        url: '/attachments',
        data: form_data
      });
    };
    reader.readAsDataURL(file);
    // console.log(this.attachmentForm.serializeArray());
  });

  // this.fileInput.change(function() {
  //   console.log(this.files);
  // })
}



$(function () {
  var selectors = {
    fileInput: 'input[type=file]',
    attachmentForm: '#attachment_form'
  };

  (new AttachmentFormHelper(selectors)).init();
});