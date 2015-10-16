$(function () {
  $(".analytics.index").ready(function () {

    $.ajax({
      method: "GET",
      url: "/api/v1/analytics_dashboard",
      dataType: "json"
    })

    .done(function(data){
      charts = data.analytics_dashboard_organizer
      // Build the chart
      var scatterKeywords = charts.scatter_plot.keywords
      var keywordCounter = 0
      $('#scatter-container').highcharts({
        chart: {
            type: 'scatter',
            zoomType: 'xy'
        },
        title: {
            text: 'Keyword Scatter'
        },
        subtitle: {
            text: ''
        },
        tooltip: {
          shared: true,
          formatter: function (args) {
            var this_point_index = this.series.data.indexOf( this.point );
            var seriesName = this.point.series.name
            if (seriesName == "Positive") {
              return charts.scatter_plot.positive_keywords[this_point_index]
            } else if (seriesName == "Negative") {
              return charts.scatter_plot.negative_keywords[this_point_index]
            } else if (seriesName == "Mixed") {
              return charts.scatter_plot.mixed_keywords[this_point_index]
            }
        }
      },
        xAxis: {
            title: {
                enabled: true,
                text: 'Sentiment'
            },
            startOnTick: true,
            endOnTick: true,
            showLastLabel: true
        },
        yAxis: {
            title: {
                text: 'Relevence'
            }
        },
        legend: {
            layout: 'vertical',
            align: 'left',
            verticalAlign: 'top',
            x: 100,
            y: 70,
            floating: true,
            backgroundColor: (Highcharts.theme && Highcharts.theme.legendBackgroundColor) || '#FFFFFF',
            borderWidth: 1
        },
        plotOptions: {
            scatter: {
                marker: {
                    radius: 5,
                    states: {
                        hover: {
                            enabled: true,
                            lineColor: 'rgb(100,100,100)'
                        }
                    }
                },
                states: {
                    hover: {
                        marker: {
                            enabled: false
                        }
                    }
                },
            }
        },
        series: [{
            name: 'Negative',
            color: 'rgba(223, 83, 83, .5)',
            data: charts.scatter_plot.negative

        }, {
            name: 'Positive',
            color: 'rgba(119, 152, 191, .5)',
            data: charts.scatter_plot.positive
        }, {
            name: 'Mixed',
            color: 'rgba(150, 100, 160, .5)',
            data: charts.scatter_plot.mixed
        }]
    });
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
            reversed: false
        },
        plotOptions: {
            series: {
                stacking: 'normal'
            }
        },
        series: charts.stacked_bar.data
      });
    });
  });
});
