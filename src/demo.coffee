randomTrendValue = () ->
  if Math.round(Math.random() * 3) < 1
    0
  else
    Math.round(Math.random() * 100) - 50

randomSparklineData = () ->
  [1..16]
    .map -> Math.round(Math.random() * 100)
    .join ','

names = ['id', 'name', 'trend', 'chart']
data = [
  [    48803,    'DSK1',   randomTrendValue(), randomSparklineData()]
  [    48769,    'APPR',   randomTrendValue(), randomSparklineData()]
  [    48777,    'OGRS',   randomTrendValue(), randomSparklineData()]
  [    48777,    'OGRS',   randomTrendValue(), randomSparklineData()]
  [    48777,    'OGRS',   randomTrendValue(), randomSparklineData()]
  [    48777,    'OGRS',   randomTrendValue(), randomSparklineData()]
  [    48777,    'OGRS',   randomTrendValue(), randomSparklineData()]
  [    48777,    'OGRS',   randomTrendValue(), randomSparklineData()]
  [    48777,    'OGRS',   randomTrendValue(), randomSparklineData()]
  [    48777,    'OGRS',   randomTrendValue(), randomSparklineData()]
  [    48777,    'OGRS',   randomTrendValue(), randomSparklineData()]
  [    48777,    'OGRS',   randomTrendValue(), randomSparklineData()]
]

renderTrend = (cellvalue) ->
  "#{cellvalue}% <i class='icon-trend icon-arrow-#{if cellvalue > 0 then 'up' else if cellvalue is 0 then 'const' else 'down' }'></i>"

renderSparklines = (cellvalue) ->
  $('<div/>')  
  .highcharts 'SparkLine',
      series: [{
          data: cellvalue.split(',').map (x) -> parseInt(x)
          pointStart: 1
      }],
      tooltip: {
          headerFormat: '<span style="font-size: 10px">Segment, Q{point.x}:</span><br/>',
          pointFormat: '<b>{point.y}.000</b> USD'
      },
      width: 225
      height: 25
  .html()

$('#grid').jqGrid
  datatype: 'local'
  height: 350
  colNames: ['ID', 'Name', 'Trend', 'Chart']
  colModel: [
    {
      name: 'id'
      index: 'id'
      width: 60
      sorttype: 'int'
      align: 'right'
    }
    {
      name: 'name'
      index: 'name'
      width: 90
      sorttype: 'string'
      align: 'center'
    }
    {
      name: 'trend'
      index: 'trend'
      width: 80,
      formatter: renderTrend
      align: 'right'
    }
    {
      name: 'chart'
      index: 'chart'
      width: 235,
      formatter: renderSparklines
    }
  ]

$grid = $('#grid')
for values, i in data
  r = {}
  for v, j in values
    r[names[j]] = v
  $grid.jqGrid 'addRowData', i + 1, r
