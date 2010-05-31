var winGraph;

var drawWinGraph = function(containerId, type, stacking) {
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

$(function(){drawWinGraph("graph-container", "column", "normal");});

