# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$('.static_pages.research').ready ->
  Highcharts.getOptions().colors = Highcharts.map(Highcharts.getOptions().colors, (color) ->
    radialGradient:
      cx: 0.5
      cy: 0.3
      r: 0.7
    stops: [
      [
        0
        color
      ]
      [ # darken
        1
        Highcharts.Color(color).brighten(-0.3).get("rgb")
      ]
    ]
  )
  $("#container").highcharts
    chart:
      plotBackgroundColor: null
      plotBorderWidth: null
      plotShadow: false
    title:
      text: ""
    tooltip:
      pointFormat: "{point.a} <b>{point.percentage:.0f}% </b> {point.b}"
    plotOptions:
      pie:
        allowPointSelect: true
        cursor: "pointer"
        dataLabels:
          enabled: true
          format: "<b>{point.name}</b>: {point.percentage:.0f} %"
          style:
            color: (Highcharts.theme and Highcharts.theme.contrastTextColor) or "black"
          connectorColor: "silver"
    series: [
      type: "pie"
      name: "Make of Happiness"
      data: [
        {
          name: "Set Point"
          y: 50.0
          a: "How much happiness is controlled by your genetics.<br/>Some people are born generally happy, others need help.<br /><i>Research shows that our genetics make up </i>"
          b: "<i> of our happiness</i>"
        }
        {
          name: "Intentional Activity"
          y: 40.0
          a: "How much happiness you can achieve by participating in<br/>activities proven to make people happier.<br /><i>Research shows that we have control over </i>"
          b: "<i> of our happiness</i>"
          sliced: true
          selected: true
        }
        {
          name: "Circumstances"
          y: 10.0
          a: "How much happiness you get from wealth, beauty, and recent events.<br /><i>Research shows our circumstances make up only </i>"
          b: "<i> of our happiness</i>"
        }
      ]
    ]
  window.startTrip = ->
    trip = new Trip([
      sel: $(".panel")
      content: "Click on the header text to expand/collapse the information boxes."
      expose: true
      position: "screen-center"
    ],
      showNavigation: true
      showCloseBox: true
      delay: -1
      animation: "fadeInUp"
    )
    trip.start()
    return
  return

$('.static_pages.about').ready ->
  window.startTrip = ->
    trip = new Trip([
      sel: $(".panel")
      content: "Click on the text to expand/collapse the information boxes."
      expose: true
      position: "screen-center"
    ],
      showNavigation: true
      showCloseBox: true
      delay: -1
      animation: "fadeInUp"
    )
    trip.start()
    return

$('.static_pages.help').ready ->
  window.startTrip = ->
    trip = new Trip([
      sel: $(".panel")
      content: "Click on the text to expand/collapse the information boxes."
      expose: true
      position: "screen-center"
    ],
      showNavigation: true
      showCloseBox: true
      delay: -1
      animation: "fadeInUp"
    )
    trip.start()
    return

$('.static_pages.home').ready ->
  window.startTrip = ->
    if $(".take-tour-sm").is(":visible")
      tt = $(".take-tour-sm")
      gs = $(".get-started-sm")
    else
      tt = $(".take-tour")
      gs = $(".get-started")
    trip = new Trip([
      {
        content: "Happs' vision is a where happiness is the highest life goal."
        position: "screen-center"
      }
      {
        content: "We do this by combining positive psychology with technology"
        position: "screen-center"
      }
      {
        content: "through free, easy-to-use tools proven to increase happiness."
        position: "screen-center"
      }
      {
        sel: tt
        content: "Take the tour to learn more"
        expose: true
        position: "n"
      }
      {
        sel: gs
        content: "or jump right in and get started."
        expose: true
        position: "n"
      }
    ],
      showNavigation: true
      showCloseBox: true
      delay: -1
      animation: "fadeInUp"
    )
    trip.start()
    return
