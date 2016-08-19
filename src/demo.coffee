randomTrendValue = () ->
  if Math.round(Math.random() * 3) < 1
    0
  else
    Math.round(Math.random() * 100) - 50

randomSparklineData = () ->
  [1..16]
    .map -> Math.round(Math.random() * 100)
    .join ','

lastID = parseInt [1..5].map(-> Math.round(Math.random() * 8) + 1).join ''
nextId = () -> lastID++

randomCode = () ->
  [1..4]
    .map -> String.fromCharCode 65 + Math.round(Math.random() * 24)
    .join ''

names = ['id', 'code', 'trend', 'chart']
data = [1..13].map ->
  [    nextId(),    randomCode(),   randomTrendValue(), randomSparklineData()]

renderTrend = (cellvalue) ->
  "#{cellvalue}% <i class='icon-trend icon-arrow-#{if cellvalue > 0 then 'up' else if cellvalue is 0 then 'const' else 'down' }'></i>"

renderSparklines = (cellvalue) ->
  $('<div/>') 
  .highcharts 'SparkLine',
      series: [{
          data: cellvalue.split(',').map (x) -> parseInt(x)
      }]
      width: 225
      height: 25
  .html()

$('#grid').jqGrid
  datatype: 'local'
  height: 350
  colNames: ['ID', 'Code', 'Trend', 'Chart']
  colModel: [
    {
      name: 'id'
      index: 'id'
      width: 60
      sorttype: 'int'
      align: 'right'
    }
    {
      name: 'code'
      index: 'code'
      width: 90
      sorttype: 'string'
      align: 'center'
    }
    {
      name: 'trend'
      index: 'trend'
      sorttype: 'number'
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
