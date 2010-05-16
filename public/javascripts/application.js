
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

monitur.winsDiv = function() { return $("#win_list");}

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

winUpdater = function() {
  var template = "<div class=\"avatar\">&nbsp;</div><div class=\"win\"><a class=\"username\" href=\"/users/{{username}}\">{{username}}</a>: {{body}}<div class=\"points\"> (+5 pts)</div></div>"
  var self = {
    update:function() {
      this.addWins(monitur.getWins());
    }, 
    addWins:function(wins) {
      var dom = Mustache.to_html(template, wins);
      monitur.winsDiv().prepend(dom);
    }
  };
  return self;  
}();



