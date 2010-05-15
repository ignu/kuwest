
var monitur = function() {
  var self = {};
  self.init =  function() {
    monitur.winform.init();
  };
  return self;
}();

monitur.winform = function() {
  var self = {};
  self.init = function() {
    $("#win").helpText();
  };
  return self;
}();

$(monitur.init);

$.fn.helpText = function(text) {
  if(!text) text = $(this).val();
  $(this).val(text);
  $(this).addClass("light")

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
