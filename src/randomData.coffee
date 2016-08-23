randomInt = (max) -> Math.round(Math.random() * max)

withProbability = (percent, v1, v2) ->
  if randomInt(100) < percent then v1 else v2

randomTrendValue = ->
  withProbability 33, 0, randomInt(100) - 50

randomSparklineData = ->
  [1..16]
    .map -> randomInt(100) - 40
    .join ','

lastID = parseInt [1..5].map(-> randomInt(8) + 1).join ''
nextId = -> lastID++

randomCode = ->
  [1..4]
    .map -> String.fromCharCode 65 + randomInt(24)
    .join ''

window.randomData = ->
  [1..50]
    .map ->
      id    : nextId()
      code  : randomCode()
      trend : randomTrendValue()
      chart : randomSparklineData()