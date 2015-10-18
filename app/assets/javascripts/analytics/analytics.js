Highcharts.setOptions({
    chart: {
        style: {
            fontFamily: 'Nunito'
        }
    }
});

var dateParser = function(dateString) {
  var date = new Date(dateString);
  var newDate = Date.parse(date);
  return newDate;
}

var formatDates = function(data) {
  var newData = []
  $.each( data, function(index, value) {
    value[0] = dateParser(value[0]);
    newData.push(value);
  })
  return newData;
}

$(function () {
  $('.analytics.index').ready(function () {
    $.ajax({
      method: 'GET',
      url: '/api/v1/analytics_dashboard',
      dataType: 'json'
    })

    .done(function(data){
      var charts = data.analytics_dashboard_organizer
      var timelineData = formatDates(charts.timeline_chart)
      // Build the chart
      $('#timeline-container').highcharts({
        chart: {
            type: 'spline',
            backgroundColor: null
        },
        colors: ['#30385f'],
        title: {
            text: 'DREAM SENTIMENT OVER TIME',
            align: 'center',
            x: 5,
            y: 25
        },
        subtitle: {
            text: ''
        },
        xAxis: {
            type: 'datetime',
            dateTimeLabelFormats: { // don't display the dummy year
                month: '%b',
                year: '%B'
            },
            title: {
                text: 'Date'
            }
        },
        yAxis: {
            title: {
                text: 'Dream Sentiment'
            },
            min: -1
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
        tooltip: {
            headerFormat: '<b>{point.x:%b %e, %Y}</b><br>',
            pointFormat: '{point.y}'
        },

        plotOptions: {
            spline: {
                marker: {
                    enabled: true
                }
            }
        },

        series: [{
            name: 'Dream Sentiment',
            marker: {
                    states: {
                        hover: {
                            fillColor: '#D2ACAF',
                        }
                    }
                },
            data: timelineData
        }]
    });

      $('#scatter-container').highcharts({
        chart: {
            type: 'scatter',
            zoomType: 'xy',
            backgroundColor: null
        },
        title: {
            text: 'KEYWORD SCATTER',
            align: 'left',
            x: 5,
            y: 25
        },
        subtitle: {
            text: ''
        },
        tooltip: {
          shared: true,
          formatter: function (args) {
            var this_point_index = this.series.data.indexOf( this.point );
            var seriesName = this.point.series.name
            if (seriesName == 'Positive') {
              return charts.scatter_plot.positive_keywords[this_point_index]
            } else if (seriesName == 'Negative') {
              return charts.scatter_plot.negative_keywords[this_point_index]
            } else if (seriesName == 'Mixed') {
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
            color: 'rgba(119, 152, 191, .5)',
            data: charts.scatter_plot.negative

        }, {
            name: 'Positive',
            color: 'rgba(223, 83, 83, .5)',
            data: charts.scatter_plot.positive
        }, {
            name: 'Mixed',
            color: 'rgba(150, 100, 160, .5)',
            data: charts.scatter_plot.mixed
        }]
    });
      $('#pie-container').highcharts({
          chart: {
              backgroundColor: null,
              plotShadow: false,
              type: 'pie'
          },
          colors: ['#D2ACAF', '#30385f'],
          title: {
              text: 'DREAM SENTIMENT BREAKDOWN',
              align: 'center',
              x: 5,
              y: 25
          },
          tooltip: {
              pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
          },
          plotOptions: {
              pie: {
                  borderColor: '#000000',
                  allowPointSelect: true,
                  cursor: 'pointer',
                  dataLabels: {
                      enabled: false
                  },
                  showInLegend: true
              }
          },
          series: [{
              name: 'Dreams',
              colorByPoint: true,
              data: charts.pie_chart
          }]
      });

      $('#stacked-bar-container').highcharts({
        chart: {
            type: 'bar',
            backgroundColor: null
        },
        title: {
            text: 'STACKED KEYWORD SENTIMENT',
            align: 'left',
            x: 5,
            y: 25
        },
        colors: ['#000000', '#30385f', '#FFFFFF', '#D2ACAF'],
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
