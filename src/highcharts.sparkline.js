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
          type: options.chartType || 'line',
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
          lineWidth: 0,
          tickPositions: [],
          gridLineWidth: 0
        },
        yAxis: {
          endOnTick: false,
          startOnTick: false,
          labels: { enabled: false },
          title: { text: null },
          tickPositions: [0],
          gridLineWidth: options.gridLine ? 1 : 0
        },
        plotOptions: {
          series: {
            color: options.color || '#7af',
            negativeColor: options.negativeColor || options.color || '#7af',
            animation: false,
            lineWidth: options.lineWidth,
            marker: {
              radius: options.markerSize
            },
            fillOpacity: options.fillOpacity
          },
          column: options.columnOptions || {
            negativeColor: '#e77',
            pointPadding: 0,
            borderWidth: .5,
            borderColor: '#333'
          }
        }
      };

    options = Highcharts.merge(defaultOptions, options);

    return hasRenderToArg
      ? new Highcharts.Chart(a, options, c) 
      : new Highcharts.Chart(options, b);
  };
})(Highcharts);
