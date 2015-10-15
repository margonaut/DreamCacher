$(function () {
  $(document).ready(function () {
    var sentiments = ["Positive", "Negative", "Neutral", "Mixed"];
    var percentages = [25, 25, 25, 25];

    $.ajax({
      method: "GET",
      url: "api/v1/analytics_dashboard",
      dataType: "json"
    })

    .done(function(data){
      charts = data.analytics_dashboard_organizer
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
              data: charts.pie_chart
          }]
      });
    //
    //   $('#stacked-bar-container').highcharts({
    //     chart: {
    //         type: 'bar'
    //     },
    //     title: {
    //         text: 'Stacked bar chart'
    //     },
    //     xAxis: {
    //         categories: ['Apples', 'Oranges', 'Pears', 'Grapes', 'Bananas']
    //         // categories: ['date string', 'datestring', 'datestring',]
    //         // categories: data["stacked-bar"]["dates"]
    //     },
    //     yAxis: {
    //         min: -6,
    //         title: {
    //             text: 'Total fruit consumption'
    //         }
    //     },
    //     legend: {
    //         reversed: true
    //     },
    //     plotOptions: {
    //         series: {
    //             stacking: 'normal'
    //         }
    //     },
    //     series: [{
    //         name: 'Negative Mixed',
    //         data: [-1, -2, -4, -3, -2]
    //     }, {
    //         name: 'Negative',
    //         data: [-5, -3, -4, -4, -2]
    //     }, {
    //         name: ' Positive Mixed',
    //         data: [2, 2, 3, 2, 1]
    //     }, {
    //         name: 'Positive',
    //         data: [3, 4, 4, 2, 5]
    //     }]
    //
    //     // series: data["stacked-bar"]["data"]
    // });
    });
  });
});
