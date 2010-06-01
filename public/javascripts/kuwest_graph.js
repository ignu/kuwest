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
      chart: { renderTo: containerId, margin: [0,0,20,0] },
      legend: { 
        enabled: true, 
        style: { 
          position: 'inline',
          zIndex: 10,  
          padding: '5px'
        } 
      },
      title: { text: '' },
      xAxis: { categories: dates, lineWidth: 0 },
      yAxis: { title: { text: '' }, gridLineWidth: 0, lineWidth: 0 },
      tooltip: {
        formatter: function(){
          return this.series.name.replace(" ", " " + this.y + " ");
        }
      },
      plotOptions: { 
        column: { 
          dataLabels: { 
            enabled: true,
            formatter: function(){ return this.y; },
            y: 18,
            style: { 
              font: '20px bold Helvetica, Verdana, Arial, sans-serif',
              color: '#fff'
            }
          },
          groupPadding: .04,
          stacking: stacking
        } 
      },
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

