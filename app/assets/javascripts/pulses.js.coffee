$ ->
  if $('.pulse').length
    activity = [
      'days': [ 0, 3, 26, 20, 39, 1, 0 ]
      'total': 89
      'week': 1383436800
    ,
      'days': [ 0, 5, 30, 15, 25, 3, 0 ]
      'total': 90
      'week': 1382832000
    ,
      'days': [ 0, 3, 26, 20, 39, 1, 0 ]
      'total': 89
      'week': 1383436800
    ,
      'days': [ 0, 5, 30, 15, 25, 3, 0 ]
      'total': 90
      'week': 1384041600
    ,
      'days': [ 0, 3, 26, 20, 39, 1, 0 ]
      'total': 89
      'week': 1384646400
    ,
      'days': [ 0, 5, 30, 15, 25, 3, 0 ]
      'total': 90
      'week': 1385251200
    ,
      'days': [ 0, 3, 26, 20, 39, 1, 0 ]
      'total': 89
      'week': 1385856000
    ,
      'days': [ 0, 3, 26, 20, 39, 1, 0 ]
      'total': 89
      'week': 1383436800
    ,
      'days': [ 0, 5, 30, 15, 25, 3, 0 ]
      'total': 90
      'week': 1382832000
    ,
      'days': [ 0, 3, 26, 20, 39, 1, 0 ]
      'total': 89
      'week': 1383436800
    ,
      'days': [ 0, 5, 30, 15, 25, 3, 0 ]
      'total': 90
      'week': 1384041600
    ,
      'days': [ 0, 3, 26, 20, 39, 1, 0 ]
      'total': 89
      'week': 1384646400
    ,
      'days': [ 0, 5, 30, 15, 25, 3, 0 ]
      'total': 90
      'week': 1385251200
    ,
      'days': [ 0, 3, 26, 20, 39, 1, 0 ]
      'total': 89
      'week': 1385856000
    ,
      'days': [ 0, 3, 26, 20, 39, 1, 0 ]
      'total': 89
      'week': 1383436800
    ,
      'days': [ 0, 5, 30, 15, 25, 3, 0 ]
      'total': 90
      'week': 1382832000
    ,
      'days': [ 0, 3, 26, 20, 39, 1, 0 ]
      'total': 89
      'week': 1383436800
    ,
      'days': [ 0, 5, 30, 15, 25, 3, 0 ]
      'total': 90
      'week': 1384041600
    ,
      'days': [ 0, 3, 26, 20, 39, 1, 0 ]
      'total': 89
      'week': 1384646400
    ,
      'days': [ 0, 5, 30, 15, 25, 3, 0 ]
      'total': 90
      'week': 1385251200
    ,
      'days': [ 0, 3, 26, 20, 39, 1, 0 ]
      'total': 89
      'week': 1385856000
    ,
      'days': [ 0, 5, 30, 15, 25, 3, 0 ]
      'total': 90
      'week': 1386460800
    ]

    interval = 15
    middle = 104
    i = interval
    negative = true

    path = 'M0,' + middle + ' L'
    for week in activity
      for day in week.days
        spike = middle + (if negative then -1 * day else day)*3
        path += i + ',' + spike + ' '

        i += interval
        negative = !negative

    pulse = document.createElementNS "http://www.w3.org/2000/svg", "path"
    $(pulse).attr
      fill: 'none'
      stroke: 'black'
      'stroke-width': '4'
      'stroke-miterlimit': '0'
      d: path

    length = pulse.getTotalLength()

    $(pulse).css
      'transition': 'none'
      '-webkit-transition': 'none'
      'stroke-dasharray': length + ' ' + length
      'stroke-dashoffset': length

    $('.pulse svg').append pulse

    setTimeout(->
      pulse.getBoundingClientRect()

      transition = 'stroke-dashoffset 3s linear'
      $(pulse).css
        'transition': transition
        '-webkit-transition': transition
        'stroke-dashoffset': '0'

      return true
    , 0)
