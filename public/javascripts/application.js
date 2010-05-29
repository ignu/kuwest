var monitur = function() {
  var self = {};
  fadeoutAlerts = function() {
    $(".alert").fadeOut();
    $(".error").fadeOut();
    $(".notice").fadeOut();
  };
  self.init =  function() {
    monitur.winform.init();
    setTimeout(fadeoutAlerts, 5000);
  };
  return self;
}();

monitur.winform = function() {

  var self = {};
  
  self.init = function() {
    var text = $("#win").val();
    $("#win").helpText(text);
    
    $(".delete").click(function() {
      var delete_link = $(this);
      $.ajax({
        url: "/wins/destroy", 
        type: "DELETE", 
        data: {id: delete_link.attr("status")}, 
        success: function() {
          delete_link.parents(".status").fadeOut()
        }
      });
      return false; 
    });
    
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

		$(".comment").click(function() {
			$(this).siblings(".comment_box").show();
			return false;
		})
	
		$(".comment_description").focusout(function() {
			if ($(this).val().length == 0) $(this).parent().hide();
      return false;
		});

		$(".submit_comment").click(function() {
			if ($(this).siblings(".comment_description").val().length == 0) return false;
			var id 						= $(this).siblings(".comment_description").attr('id').replace(/comment_/i,''); 
			var parent 				= $(this).parent();
			var comment_desc 	= $(this).siblings(".comment_description");
			$.ajax({
				url: '/wins/comment/' + id,
				type: "POST",
				data: {
					body: comment_desc.val()
				},
				success: function(data) {
					comment_desc.val("");
					parent.hide();
					return false;
				}
			})
      return false;
		});
  };
  return self;
}();

monitur.winsDiv = function() { return $("#win_list");};

$(monitur.init);

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



