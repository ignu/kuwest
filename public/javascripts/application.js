var kuwest = function() {
  var self = {};

  var appendMessageDiv = function(class, message) {
    return $("<div class=\"" + class + "\">")
      .appendTo("body")
      .text(message);
    };

  var displayMessage = function(class) {
     return function(message) {
       var div = appendMessageDiv(class, message);
       setTimeout(function() {div.fadeOut();}, 3500);
     };
  };

  self.ajax = function(){
    var me = {};
    var div;
    me.start = function() {
      div = appendMessageDiv("notice", "Loading...");
    };
    me.end = function() {
      div.fadeOut();
    };
    return me;
  }();
  self.error  = displayMessage("error");
  self.notice = displayMessage("notice");
  self.alert  = displayMessage("alert");

  var fadeoutAlerts = function() {
    $(".alert").fadeOut();
    $(".error").fadeOut();
    $(".notice").fadeOut();
  };

  self.init =  function() {  
    kuwest.winform.init();
    kuwest.comments.init();
    setTimeout(fadeoutAlerts, 5000);
  };

  return self;
}();

kuwest.comments = function() {
  var x = 1;
  var self = {};
  var wire_upload = function(id, wrapper) {
      new AjaxUpload(id, {
          action:       '/wins/picture',
          name:         'photo',
          data:         {id: id.replace(/upload/, '')},
          autoSubmit:   true,
          responseType: false,

          onChange:     function(file, ext) {
                          if(ext && /(png|jpg|jpeg|gif)/.test(ext)) return true;
                          kuwest.error("You can only upload images!");
                          return false;
          },
          onSubmit:     function(file, ext) {
                          kuwest.ajax.start();
                          if(ext && /(png|jpg|jpeg|gif)/.test(ext)) return true;
                          kuwest.error("You can only upload images!");
                          return false; 
                        },
          onComplete:  function(file, response) {
                          $("#" + id).fadeOut();
                          wrapper.prepend(response);
                          kuwest.ajax.end();
                          kuwest.notice(file + " uploaded");
                       }
        });
  };

  self.wire_upload_links = function() {
    $(".upload").each(function() {
      wire_upload($(this).attr("id"), $(this).siblings(".comments"));
      $(this).removeClass("upload"); 
    });
  };


  self.init = function() {
    var wrapper;

    var expand_wrapper = function() {
      wrapper.height(wrapper.height() + 140);
    };

    var collapse_wrapper = function() {
      wrapper.height(wrapper.height() - 140);
    };

    self.wire_upload_links();

	$(".comment").click(function() {
      var comment_box = $(this).siblings(".comment_box");
      comment_box.show();
      wrapper = $(this).parents(".action_wrapper");
      expand_wrapper();
      comment_box.find('.comment_description').focus();
      return false;
      });
	
//	$(".comment_description").focusout(function() {
//	  if ($(this).val().length == 0) $(this).parent().hide();
//      collapse_wrapper();
//      return false;
//	  });

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
                  wrapper.siblings(".comments").append(data);
                  collapse_wrapper();
                  return false;
				}
			});
      return false;
	 });
  };
  return self;
}();


kuwest.winform = function() {
  var self = {};

  self.init = function() {
    var text = $("#win").val();
    $("#win").helpText(text);
    
    $(".delete").click(function() {
      var delete_link = $(this);
      $.ajax({
        url:     "/wins/destroy",
        type:    "DELETE",
        data:    {id: delete_link.attr("status")},
        success: function() {
                  delete_link.parents(".status").fadeOut()
                 }
      });
      return false; 
    });
    
    $("#submit_win").click(function() {
      if ($("#win").val() == text) { kuwest.error("Please enter some text."); return false;}
      kuwest.ajax.start();
      $.ajax({
        url:     '/wins/create',
        type:    "POST",
        data:    {body:   $("#win").val()},
        success: function(data) {
                  $("table.win").prepend(data);
                  kuwest.comments.wire_upload_links();
                  $("#win").val(text);  // TODO: dry
                  $("#win").addClass("light");
                  kuwest.ajax.end();
                  return false;
                 }
      });
      return false;
    }); // submit win
  };
  
  return self;
}();

$('.status_image img').live('click', function() {
    var url = $(this).attr("src").replace(/small/, 'original');
    $.slimbox(url, '');
});
$('.profile_image img').live('click', function() {
    var url = $(this).attr("src").replace(/\/profile/, '/original');
    $.slimbox(url, '');
});

kuwest.winsDiv = function() { return $("#win_list");};

$(kuwest.init);

var winUpdater = function() {
  var template = "<div class=\"avatar\">&nbsp;</div><div class=\"win\"><a class=\"username\" href=\"/users/{{username}}\">{{username}}</a>: {{body}}<div class=\"points\"> (+5 pts)</div></div>"
  var self = {
    update:function() {
      this.addWins(kuwest.getWins());
    }, 
    addWins:function(wins) {
      var dom = Mustache.to_html(template, wins);
      kuwest.winsDiv().prepend(dom);
    }
  };
  return self;  
}();


