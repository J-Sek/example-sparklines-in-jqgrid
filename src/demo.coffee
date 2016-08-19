data = [
  [    48803,    'DSK1',   '02200220',    'OPEN'   ]
  [    48769,    'APPR',   '77733337',    'ENTERED']
  [    48777,    'OGRS',   '12312311',    'ENTERED']
]
$('#grid').jqGrid
  datatype: 'local'
  height: 250
  colNames: ['Inv No', 'Thingy', 'Number', 'Status']
  colModel: [
    {
      name: 'id'
      index: 'id'
      width: 160
      sorttype: 'int'
      align: 'right'
    }
    {
      name: 'thingy'
      index: 'thingy'
      width: 190
      sorttype: 'date'
    }
    {
      name: 'number'
      index: 'number'
      width: 180
      sorttype: 'float'
      align: 'right'
    }
    {
      name: 'status'
      index: 'status'
      width: 180
      sorttype: 'float'
    }
  ]
names = ['id', 'thingy','number','status']

$grid = $('#grid')

for values, i in data
  r = {}
  for v, j in values
    r[names[j]] = v
  $grid.jqGrid 'addRowData', i + 1, r


$grid.jqGrid 'setGridParam', ondblClickRow: (rowid, iRow, iCol, e) ->
  alert 'double clicked'
  return

$($('td[role="gridcell"]:nth-child(4)')[2])
.highcharts 'SparkLine',
    series: [{
        data: [8, 32, 80, 96],
        pointStart: 1
    }],
    tooltip: {
        headerFormat: '<span style="font-size: 10px">Segment, Q{point.x}:</span><br/>',
        pointFormat: '<b>{point.y}.000</b> USD'
    },
    chart: {}
      