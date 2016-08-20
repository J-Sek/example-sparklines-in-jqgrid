data = randomData()

renderTrend = (cellvalue) ->
  arrowType = switch
    when cellvalue > 0 then 'up'
    when cellvalue is 0 then 'const'
    else 'down'

  "#{cellvalue}% <i class='icon-trend icon-arrow-#{arrowType}'></i>"

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

for row, i in data
  $grid.jqGrid 'addRowData', i + 1, row
