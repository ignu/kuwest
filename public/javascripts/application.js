var monitur = function() {
  var self = {};
  fadeoutAlerts = function() {
    $(".alert").fadeOut();
    $(".error").fadeOut();
    $(".notice").fadeOut();
  };
  self.init =  function() {  
    monitur.winform.init();
    monitur.comments.init();
    setTimeout(fadeoutAlerts, 5000);
    drawWinGraph("graph-container", "column", "normal");
  };
  return self;
}();

monitur.comments = function() {
  var self = {};

  self.init = function() {
    var wrapper;

    var expand_wrapper = function() {
      wrapper.height(wrapper.height() + 140);
    };

    var collapse_wrapper = function() {
      wrapper.height(wrapper.height() - 140);
    };
  $(".upload").click(function() {
      var upload_box = $(this).siblings(".upload_form");
      upload_box.show();
      wrapper = $(this).parents(".action_wrapper");
      expand_wrapper();
      upload_box.find(".file").focus();
      return false;
  });
	$(".comment").click(function() {
      var comment_box = $(this).siblings(".comment_box");
      comment_box.show();
      wrapper = $(this).parents(".action_wrapper");
      expand_wrapper();
      comment_box.find('.comment_description').focus();
      return false;
      });
	
	$(".comment_description").focusout(function() {
			if ($(this).val().length == 0) $(this).parent().hide();
      collapse_wrapper();
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
          wrapper.siblings(".comments").append(data);
          collapse_wrapper();
					return false;
				}
			})
      return false;
		});
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
          $("table.win").prepend(data);
          $("#win").val(text);  // TODO: dry
          $("#win").addClass("light");
          return false;
          winUpdater.addWins(data);
          return false;
        }
      });
      return false;
    }); // submit win
  };
  return self;
}();


monitur.winsDiv = function() { return $("#win_list");};

var winGraph;
drawWinGraph = function(containerId, type, stacking) { 
  var username = $("#username").text(); //TODO: change this to hidden input?
  $.get('/users/' + username + '?format=json', function(json){  
    var dates = [];
    var series = [];
    $.each(json.dates, function(index, value){
      dates.push(value);
    });
    $.each(json.activities, function(index, value){
      series.push({type: type, name: value.phrase, data: value.amounts});
    });
    winGraph = new Highcharts.Chart({
      chart: { renderTo: containerId },
      title: { text: 'wins' },
      xAxis: { categories: dates },
      yAxis: { title: { text: '' } },
      plotOptions: { column: { dataLabels: { enabled: true }, stacking: stacking } },
      credits: { enabled: false },
      series: series
    });
  });

  $("#line-graph").click(function(){
    $("#graph-container").html("");
    drawWinGraph('graph-container', 'line', null);
  });
  $("#column-graph").click(function(){
    $("#graph-container").html("");
    drawWinGraph('graph-container', 'column', null);
  });
  $("#stacked-column-graph").click(function(){
    $("#graph-container").html("");
    drawWinGraph('graph-container', 'column', 'normal');
  });
};

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



