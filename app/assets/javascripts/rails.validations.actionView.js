window.ClientSideValidations.formBuilders['ActionView::Helpers::FormBuilder'] = {
  add: function(element, settings, message) {
    // custom add code here
    
    element.addClass('is-invalid');
    return element.parent().append($("<div class=\"invalid-feedback\">" + message + "</div>"))

  },

  remove: function(element, settings) {
    // custom remove code here

    element.removeClass('is-invalid');
    return element.siblings('.invalid-feedback').remove();
  }
}