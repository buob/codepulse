window.Pulse =
  draw: (activity) ->
    interval = 15
    middle = 104
    explosionWeight = 4
    negative = true
    viewWidth = 2000
    i = interval

    path = 'M' + viewWidth + ',' + middle + ' L'
    for day in activity
      commits = day.commits
      spike = middle + (if negative then -1 * commits else commits) * explosionWeight
      path += (viewWidth - i) + ',' + spike + ' '

      i += interval
      negative = !negative if commits > 0

    path += (viewWidth - i) + ',' + middle + ' 0,' + middle

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
      'stroke-dashoffset': '-' + length + 'px'

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
