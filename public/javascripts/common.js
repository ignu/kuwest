$.fn.helpText = function(text) {
  if(!text) text = $(this).val();
  $(this).val(text);
  $(this).addClass("light")
  $(this).data("helpText", text);
  $(this).click(function() {
    if($(this).val() == text) {
      $(this).val('');
      $(this).removeClass("light");
    }
  });

  $(this).blur(function() {
    if(!$(this).val()) {
      $(this).val(text);
      $(this).addClass("light");
    }
  });
};

var log = function(message) {
  if(console && console.log) console.log(message);
};