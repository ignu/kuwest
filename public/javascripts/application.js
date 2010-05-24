
var monitur = function() {
  var self = {};
  fadeoutAlerts = function() {
    $(".alert").fadeOut();
  };
  self.init =  function() {
    monitur.winform.init();
    setTimeout(fadeoutAlerts,5000);
  };
  return self;
}();

monitur.winform = function() {
  var self = {};
  self.init = function() {
    var text = $("#win").val();
    $("#win").helpText(text);
    $("#submit_win").click(function() {
      if ($("#win").val() == text) return false;
      $.ajax({
        url: '/wins/create',
        type: "POST",
        data: {
          body: $("#win").val()
        },
        success: function(data) {
          winUpdater.addWins(data);
          $("#win").val(text);  // TODO: dry
          $("#win").addClass("light");
          return false;
        }
      })
      return false;
    })

  };
  return self;
}();

monitur.winsDiv = function() { return $("#win_list");}

$(monitur.init);

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



