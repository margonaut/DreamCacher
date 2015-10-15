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

      $('#stacked-bar-container').highcharts({
        chart: {
            type: 'bar'
        },
        title: {
            text: 'Keyword Sentiment Proportion'
        },
        xAxis: {

            categories: charts.stacked_bar.dates
        },
        yAxis: {
            min: -6,
            title: {
                text: 'Total keywords'
            }
        },
        legend: {
            reversed: true
        },
        plotOptions: {
            series: {
                stacking: 'normal'
            }
        },
        series: charts.stacked_bar.data

        // series: data["stacked-bar"]["data"]
    });
    });
  });
});
