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


jQuery.fn.center = function () {
    this.css("position","absolute");
    this.css("top", ( $(window).height() - this.height() ) / 2+$(window).scrollTop() + "px");
    this.css("left", ( $(window).width() - this.width() ) / 2+$(window).scrollLeft() + "px");
    return this;
}

