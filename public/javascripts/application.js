var xpHint = function() {
  $(".xp").each(function() {
    var tipId = $(this).attr("id") + "xp";
    $(this).bubbletip($("#" +tipId), {
      deltaDirection: "left" 
    });
   })
}

$(xpHint);

var kuwest = function() {
  var self = {};

  var reloadBrokenImages = function() {
     $('img').each(function() {
        if (!this.complete || typeof this.naturalWidth == "undefined" || this.naturalWidth == 0) {
          var src = $(this).attr("src");
          var new_src  = src.replace(/thumb|small/, "original"); 
          $(this).attr("src", new_src);

          var fixSizes = function() {
            $("img.thumb").css("max-width", "73px");
            $("img.profile").css("max-width", "248px");
            $("img.status").css("max-width", "180px");
          };
          setTimeout(fixSizes, 100);
        }
      });
  };
 
  var setupLevelMeter = function() {
    var bar= $("#xp_bar");
    if(!bar.length) return;
    var percent_complete = $('<div class="complete">');
    bar.append(percent_complete);
    var w = bar.attr("progress") * bar.width();
    percent_complete.css("width", w);
  };
  var setupBubbleTip = function() {
    $('<div id="stupidDiv">').css({position:"absolute", left:"-9999"}).appendTo($("body"));

    $("#stupidDiv").bubbletip($("#flashBubble"), {
      deltaDirection: 'right',
      positionAtElement: $("#logo img"),
      bindShow:"click"
    });
  };

  var appendMessageDiv = function(klass, message) {
    return $("<div class=\"" + klass + "\">").appendTo("body").text(message);
    };

  var showMessage = function(message) {
      $(".bubbletip").show();
      $("#flashBubble").html(message);
      $("#stupidDiv").trigger("click");
  };
  var hideMessage = function() {
    $(".bubbletip").fadeOut()
  };
  var displayMessage = function(klass) {
     return function(message) {
      showMessage(message);
      setTimeout(function() {hideMessage}, 3500);
     };
  };

  var give_first_input_focus = function() {
    $("input.focus:first").focus();
  };

  self.ajax = function(){
    var me = {};
    var div;
    me.start = function() {
      displayMessage("notice", "Loading...");
    };
    me.end = function() {
      hideMessage();
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


  var loadTypeKit = function() {
    try{Typekit.load();}catch(e){}
  };

  self.init =  function() {  
    loadTypeKit();
    setupLevelMeter();
    setupBubbleTip();
  if ($("#user-information").length) { $("#content").css("float", "right");  };
  $(".tweets").tweet({
      username: "kuwest",
      count: 1,
      loading_text: "loading tweets...", 
      compose_tweet: function(avatar, date, join, text) { return text + '<div class="date">' + date + "</date>"}
    });
    kuwest.tip.init();
    kuwest.winform.init();
    kuwest.comments.init();
    give_first_input_focus();
    $(".soon").click(function() { self.notice("Coming Soon.  But <a href=\"/users/new\">sign up now</a> and start leveling up!"); return false;}); 
    $("#bubbleTip").click(function() { window.location("/users/new");})
    setTimeout(reloadBrokenImages, 1300);
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

  $("#expand_profile").toggle(function() {
    $(".profile").fadeIn();
    $(this).text("Hide Profile Details...");
  }, function() {$(".profile").fadeOut(); $(this).text("Show Profile Details...")}).css("pointer", "cursor");

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
    $("#status_form").inputHintOverlay(2, 25, {color:"#999"});
    $("form.login").inputHintOverlay(-3,5);
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
    
    $("#status_form").submit(function() {
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
                 },
          error: function(request, type) {
            kuwest.error(request.responseText);
          },
          complete: function(xhr) {
              if(xhr.status == 302) {document.location="/users/new"}
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

kuwest.tip = function() { 
  var tip, washout;
  var self = {};
  self.show = function(message) {
    washout.show();
    tip.find(".tip").html(message);
    tip.center();
    tip.fadeIn(80);
  };
  self.init = function() {
    tip = $("#tip");
    washout = $("#washout");
    $(".close").click(function() {
      washout.hide();
      tip.fadeOut(90);
    });
   $("a.tip").click(function() {
      $.get($(this).attr("href"), 
         function(html) {
          self.show(html);
         });
      return false;
      });
  };
  return self;
}();
kuwest.winsDiv = function() { return $("#win_list");};

$(kuwest.init);

var winUpdater = function() {
  var template = "<div class=\"avatar\">&nbsp;</div><div class=\"win\"><a class=\"username\" href=\"/users/{{username}}\">{{username}}</a>: {{body}}<div class=\"points\"> (+5 pts)</div></div>";
  return  {
    update:function() {
      this.addWins(kuwest.getWins());
    }, 
    addWins:function(wins) {
      var dom = Mustache.to_html(template, wins);
      kuwest.winsDiv().prepend(dom);
    }
  };
}();

/*
 * jQuery Input Hint Overlay plugin v1.1.9, 2010-04-14
 * Only tested with jQuery 1.4.1 (early versions - YMMV)
 * 
 *   http://jdeerhake.com/inputHintOverlay.php
 *   http://plugins.jquery.com/project/inputHintOverlay
 *
 *
 * Copyright (c) 2010 John Deerhake
 *
 * Dual licensed under the MIT and GPL licenses:
 *   http://www.opensource.org/licenses/mit-license.php
 *   http://www.gnu.org/licenses/gpl.html
 */
jQuery.fn.inputHintOverlay = function (topNudge, leftNudge, userStyle) {
	topNudge = typeof(topNudge) != 'undefined' ? topNudge : 0;
	leftNudge = typeof(leftNudge) != 'undefined' ? leftNudge : 0;
	var suffix = 'jqiho';
	return this.each(function (){
		var curParent = jQuery(this);
		var textAreas = jQuery(this).find("textarea");
		var pass = jQuery(this).find("input[type=password]")
		jQuery(this).find("input[type=text]").add(textAreas).add(pass).each(function() {
			var relHint = jQuery(this).attr('title');
			var curValue = jQuery(this).attr('value');
			var inp = jQuery(this);
			var safeHint;
			if(relHint) {
				safeHint = relHint.replace(/[^a-zA-Z0-9]/g, '');
				jQuery(this).wrap("<div style='display:inline; position:relative' id='wrap" + safeHint + suffix + "' />");
				var wrap = jQuery(this).parent();
				var newPos = jQuery(this).position();
				newZ = jQuery(this).css('z-index');
				if(newZ == "auto") newZ = "2000";
				else newZ = newZ + 20;
				var newCSS = {
					'position' : 'absolute',
					'z-index' : newZ,
					'left' : newPos['left'] + leftNudge,
					'top': newPos['top'] + topNudge,
					'cursor' : 'text'
				};
        $.extend(newCSS, userStyle);
				var newDiv = jQuery(document.createElement('label'))
					.appendTo(wrap)
					.attr('for', jQuery(this).attr('id'))
					.attr('id', safeHint + suffix)
					.addClass('inputHintOverlay')
					.html(relHint)
					.css(newCSS)
					.click(function() {
						jQuery(this).toggle(false);
						inp.trigger("focus");
					});
			}
			if(curValue) {
				newDiv.toggle(false);
			}
			jQuery(this).focus(function() {
				newDiv.toggle(false);
			});
			jQuery(this).blur(function() {
				if (jQuery(this).attr('value') == "") { newDiv.toggle(true); }
			});
		});
	});
}


