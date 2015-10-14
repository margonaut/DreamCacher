$(function () {
  $(document).ready(function () {
    var sentiments = ["Positive", "Negative", "Neutral", "Mixed"];
    var percentages = [25, 25, 25, 25];

    $.ajax({
      method: "GET",
      url: "/api/v1/dreams",
      dataType: "json",
      data: {chart: "pie"}
    })

    .done(function(data){
      debugger;
    });
      // Build the chart
      $('#pie-container').highcharts({
          chart: {
              plotBackgroundColor: null,
              plotBorderWidth: null,
              plotShadow: false,
              type: 'pie'
          },
          title: {
              text: 'Dream Sentiment'
          },
          tooltip: {
              pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
          },
          plotOptions: {
              pie: {
                  allowPointSelect: true,
                  cursor: 'pointer',
                  dataLabels: {
                      enabled: false
                  },
                  showInLegend: true
              }
          },
          series: [{
              name: "Dreams",
              colorByPoint: true,
              data: [{
                  name: "Positive",
                  y: 56.33
              }, {
                  name: "Negative",
                  y: 24.03,
                  sliced: true,
                  selected: true
              }, {
                  name: "Neutral",
                  y: 10.38
              }, {
                  name: "Mixed",
                  y: 4.77
              }]
          }]
      });
  });
});