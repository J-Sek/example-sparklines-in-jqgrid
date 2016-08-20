/* global Highcharts */
(function (Highcharts) {

  if (!Highcharts) {
    throw new Error('Cannot create SparkLine chart constructor without Highcharts');
  }

  Highcharts.SparkLine = function(a, b, c) {
    var hasRenderToArg = typeof a === 'string' || a.nodeName,
      options = arguments[hasRenderToArg ? 1 : 0],
      defaultOptions = {
        
        title: { text: '' },
        legend: { enabled: false },
        credits: { enabled: false },
        tooltip: { enabled: false },

        chart: {
          renderTo: (options.chart && options.chart.renderTo) || this,
          backgroundColor: null,
          borderWidth: 0,
          type: 'area',
          margin: [2, 0, 2, 0],
          width: options.width || 120,
          height: options.height || 20,
          style: { overflow: 'visible' },
          skipClone: true
        },
        xAxis: {
          endOnTick: false,
          startOnTick: false,
          labels: { enabled: false },
          title: { text: null },
          tickPositions: []
        },
        yAxis: {
          endOnTick: false,
          startOnTick: false,
          labels: { enabled: false },
          title: { text: null },
          tickPositions: [0]
        },
        plotOptions: {
          series: {
            animation: false,
            lineWidth: 1,
            shadow: false,
            states: {
              hover: {
                lineWidth: 1
              }
            },
            marker: {
              radius: 1,
              states: {
                hover: {
                  radius: 2
                }
              }
            },
            fillOpacity: 0.5
          },
          column: {
            negativeColor: '#910000',
            borderColor: 'silver'
          }
        }
      };

    options = Highcharts.merge(defaultOptions, options);

    return hasRenderToArg
      ? new Highcharts.Chart(a, options, c) 
      : new Highcharts.Chart(options, b);
  };
})(Highcharts);
