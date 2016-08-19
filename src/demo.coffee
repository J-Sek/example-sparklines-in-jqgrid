randomData = () ->
  [1..16]
    .map -> Math.round(Math.random() * 100)
    .join ','

names = ['id', 'name', 'trend']
data = [
  [    48803,    'DSK1',   randomData()]
  [    48769,    'APPR',   randomData()]
  [    48777,    'OGRS',   randomData()]
  [    48777,    'OGRS',   randomData()]
  [    48777,    'OGRS',   randomData()]
  [    48777,    'OGRS',   randomData()]
  [    48777,    'OGRS',   randomData()]
  [    48777,    'OGRS',   randomData()]
  [    48777,    'OGRS',   randomData()]
  [    48777,    'OGRS',   randomData()]
  [    48777,    'OGRS',   randomData()]
  [    48777,    'OGRS',   randomData()]
]



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
  colNames: ['ID', 'Name', 'Trend']
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
