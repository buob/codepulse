window.Pulse =
  monthNames: [ "January", "February", "March", "April", "May", "June",
      "July", "August", "September", "October", "November", "December" ]

  ordinalize: (n) ->
   s = ["th","st","nd","rd"]
   v = n % 100
   n + (s[(v-20)%10]||s[v]||s[0])

  draw: (activity) ->
    viewWidth = 2000
    viewHeight = 208
    interval = 16
    middle = viewHeight / 2
    explosionWeight = 4
    negative = true
    i = interval

    pulsePath = 'M' + viewWidth + ',' + middle + ' L'
    for day in activity
      commits = day.commits
      x = (viewWidth - i)
      y = middle + (if negative then -1 * commits else commits) * explosionWeight
      date = new Date(day.date)

      hoverTarget = document.createElementNS "http://www.w3.org/2000/svg", "rect"
      $(hoverTarget).attr(
        fill: '#000'
        stroke: 'none'
        width: interval
        height: viewHeight
        x: x - interval/2
        y: 0
        title: day.commits +
          ' commit' + (if day.commits is 1 then '' else 's') +
          ' on ' + @monthNames[date.getMonth()] + ' ' +
          @ordinalize(date.getDate())
      ).data(
        date: day.date
      ).appendTo('.pulse svg')

      circle = document.createElementNS "http://www.w3.org/2000/svg", "circle"
      $(circle).attr(
        fill: 'black'
        stroke: 'none'
        cx: x
        cy: y
        r: '5'
        class: 'd-' + day.date
      ).data(
        classes: 'd-' + day.date
      ).prependTo('.pulse svg')

      bar = document.createElementNS "http://www.w3.org/2000/svg", "path"
      $(bar).attr(
        fill: 'none'
        stroke: 'black'
        'stroke-width': '2'
        d: 'M' + x + ',' + 0 + ' L' + x + ',' + viewHeight
        class: 'bar d-' + day.date
      ).data(
        classes: 'bar d-' + day.date
      ).prependTo('.pulse svg')

      pulsePath += x + ',' + y + ' '

      i += interval
      negative = !negative if commits > 0

    pulsePath += (viewWidth - i) + ',' + middle + ' 0,' + middle

    pulse = document.createElementNS "http://www.w3.org/2000/svg", "path"
    $(pulse).attr(
      fill: 'none'
      stroke: 'black'
      'stroke-width': '4'
      'stroke-miterlimit': '0'
      d: pulsePath
    )

    length = pulse.getTotalLength()

    $(pulse).css(
      'transition': 'none'
      '-webkit-transition': 'none'
      'stroke-dasharray': length + ' ' + length
      'stroke-dashoffset': '-' + length + 'px'
    ).prependTo('.pulse svg')

    setTimeout(->
      pulse.getBoundingClientRect()

      transition = 'stroke-dashoffset 3s linear'
      $(pulse).css
        'transition': transition
        '-webkit-transition': transition
        'stroke-dashoffset': '0'

      $('.pulse').on('mouseover', 'rect', ->
        $('.d-' + $(@).data('date')).each -> $(@).attr('class', $(@).data('classes') + ' active')
      ).on('mouseout', 'rect', ->
        $('.d-' + $(@).data('date')).each -> $(@).attr('class', $(@).data('classes'))
      )

      return true
    , 0)
