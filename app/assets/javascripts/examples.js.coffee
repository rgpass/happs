# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(".examples.profile_complete, .examples.profile_start").ready ->
	alignHeights = ->
		effectiveHeight = $(".my-effective-activities").height()
		happinessHeight = $(".my-happiness").height()
		historyHeight = $(".my-activity-history").height()
		breakdownHeight = $(".my-activity-breakdown").height()
		if effectiveHeight > happinessHeight
		  $(".my-happiness").height effectiveHeight
		else
		  $(".my-effective-activities").height happinessHeight
		if historyHeight > breakdownHeight
		  $(".my-activity-breakdown").height historyHeight
		else
		  $(".my-activity-history").height breakdownHeight
		return
	alignHeights()
	waitForFinalEvent = (->
	  timers = {}
	  (callback, ms, uniqueId) ->
	    uniqueId = "Don't call this twice without a uniqueId"  unless uniqueId
	    clearTimeout timers[uniqueId]  if timers[uniqueId]
	    timers[uniqueId] = setTimeout(callback, ms)
	    return
	)()
	$(window).resize ->
	  waitForFinalEvent alignHeights(), 25, "div heights"
	  return

$('.examples.profile_complete').ready ->
  $("#container1").highcharts
    chart:
      type: "spline"
    title:
      text: ""
    subtitle:
      text: ""
    xAxis:
      type: "datetime"
      dateTimeLabelFormats:
        day: "%b"
        month: "%b"
        year: "%b"
      title:
        text: ""
    yAxis:
      title:
        text: ""
      max: 100
    tooltip:
      headerFormat: "<b>Happiness Level</b><br>"
      pointFormat: "{point.x:%b %e}: {point.y:.0f} / 100"
    series: [
      showInLegend: false
      data: [
        [
          Date.UTC(2014, 6, 15)
          78
        ]
        [
          Date.UTC(2014, 6, 30)
          83
        ]
        [
          Date.UTC(2014, 7, 18)
          81
        ]
        [
          Date.UTC(2014, 8, 8)
          88
        ]
        [
          Date.UTC(2014, 8, 28)
          92
        ]
        [
          Date.UTC(2014, 9, 19)
          84
        ]
        [
          Date.UTC(2014, 10, 2)
          87
        ]
        [
          Date.UTC(2014, 10, 20)
          90
        ]
      ]
      pointInterval: 24 * 3600 * 1000 # 1d
    ]
  return

$('.examples.profile_complete').ready ->
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
  $("#container2").highcharts
    chart:
      plotBackgroundColor: null
      plotBorderWidth: null
      plotShadow: false
    title:
      text: ""
    subtitle:
      text: "<small>Mouseover for more info</small>"
    tooltip:
      pointFormat: "<b>{point.percentage:.1f}% </b>"
    plotOptions:
      pie:
        allowPointSelect: true
        cursor: "pointer"
        dataLabels:
          enabled: false
        size: 250
    # events: {
    # 	click: function() {
    # 		window.location = '/examples/activity'
    # 	}
    # }
    series: [
      type: "pie"
      name: "Make of Happiness"
      data: [
        {
          name: "Expressing gratitude"
          y: 4 + 1 / 6
        }
        {
          name: "Savoring life's joys"
          y: 3 + 5 / 6
        }
        {
          name: "Practicing acts of kindness"
          y: 3.5
        }
        {
          name: "Doing more activities that truly engage you"
          y: 3.5
        }
        {
          name: "Cultivating optimism"
          y: 3
        }
        {
          name: "Practicing religion and spirituality"
          y: 2 + 2 / 3
        }
        {
          name: "Committing to your goals"
          y: 2 + 1 / 6
        }
        {
          name: "Avoiding overthinking and social comparison"
          y: 2
        }
        {
          name: "Nurturing relationships"
          y: 1.5
        }
        {
          name: "Taking care of your body"
          y: 5 / 6
        }
        {
          name: "Developing strategies for coping"
          y: 0.5
        }
        {
          name: "Learning to forgive"
          y: 0
        }
      ]
    ]
  return

$('.examples.profile_complete').ready ->
  $("#container3").highcharts
    chart:
      plotBackgroundColor: null
      plotBorderWidth: null
      plotShadow: false
    title:
      text: ""
    subtitle:
      text: "<small>Mouseover for more info</small>"
    tooltip:
      pointFormat: "<b>{point.y} Completed -- {point.percentage:.1f}% of Total</b>"
    plotOptions:
      pie:
        allowPointSelect: true
        cursor: "pointer"
        dataLabels:
          enabled: false
        size: 250
    # events: {
    # 	click: function() {
    # 		window.location = '/examples/activity'
    # 	}
    # }
    series: [
      type: "pie"
      name: "Make of Happiness"
      data: [
        {
          name: "Expressing gratitude"
          y: 5
        }
        {
          name: "Savoring life's joys"
          y: 4
        }
        {
          name: "Practicing acts of kindness"
          y: 3
        }
        {
          name: "Doing more activities that truly engage you"
          y: 3
        }
        {
          name: "Cultivating optimism"
          y: 2
        }
        {
          name: "Practicing religion and spirituality"
          y: 2
        }
        {
          name: "Committing to your goals"
          y: 1
        }
        {
          name: "Avoiding overthinking and social comparison"
          y: 1
        }
        {
          name: "Nurturing relationships"
          y: 2
        }
        {
          name: "Taking care of your body"
          y: 4
        }
        {
          name: "Developing strategies for coping"
          y: 0
        }
        {
          name: "Learning to forgive"
          y: 0
        }
      ]
    ]
  return

$('.examples.profile_complete').ready ->
	window.startTrip = ->
	  trip = new Trip([
	    {
	      sel: $(".container-fluid")
	      content: "Welcome to to the Happs tour!<br/><small>Note: You can use the arrow keys to navigate.</small>"
	      position: "screen-center"
	    }
	    {
	      sel: $(".container-fluid")
	      content: "In this tour, we’re going to run you through<br/>an example profile and how to get around."
	      position: "screen-center"
	    }
	    {
	      sel: $(".container-fluid")
	      content: "If you accidentally exit out or at any point<br/>you get lost, click the <i class='fa fa-question-circle fa-lg'></i> at the top."
	      position: "screen-center"
	    }
	    {
	      sel: $(".container-fluid")
	      content: "Happs uses scientifically proven<br/>techniques to do three things:"
	      position: "screen-center"
	    }
	    {
	      sel: $(".my-happiness")
	      content: "(1) Quantify and track happiness over time"
	      expose: true
	      position: "n"
	    }
	    {
	      sel: $(".my-effective-activities")
	      content: "(2) Determine which activities<br/>best match your personality"
	      expose: true
	      position: "n"
	    }
	    {
	      sel: $(".history")
	      content: "and (3) Guide you through activities<br/>that will make you happier"
	      expose: true
	      position: "n"
	    }
	    {
	      sel: $(".dashboard")
	      content: "All of these are optional. What<br/>you want to do is up to you."
	      expose: true
	      position: "n"
	    }
	    {
	      sel: $(".next-step")
	      content: "However, Happs will always<br/>provide a suggested next step."
	      expose: true
	      position: "n"
	    }
	    {
	      sel: $(".next-step")
	      content: "This is based off your activity history and<br/>Person-Activity Fit Diagnostic results."
	      expose: true
	      position: "n"
	      callback: ->
	        window.location = "/examples/ohq"
	        return
	    }
	  ],
	    showNavigation: true
	    showCloseBox: true
	    delay: -1
	    animation: "fadeInUp"
	    onTripChange: (i, tripData) ->
	      $("html, body").animate
	        scrollTop: $(tripData.sel).offset().top - 125
	      , 1000
	      return
	  )
	  trip.start()
	  return	  
	startTrip()

$('.examples.ohq').ready ->
	window.startTrip = ->
	  trip = new Trip([
	    {
	      content: "Happs utilizes two questionnaires:"
	      position: "screen-center"
	    }
	    {
	      content: "The Oxford Happiness Questionnaire<br/>to quantify your happiness and"
	      position: "screen-center"
	    }
	    {
	      content: "the Person-Activity Fit Diagnostic to determine<br/>which activites best match your personality."
	      position: "screen-center"
	    }
	    {
	      sel: $(".overview")
	      content: "Each of these questionnaires will explain their<br/>purpose, estimated time to complete,<br/>and suggested frequency."
	      expose: true
	      position: "n"
	    }
	    {
	      sel: $(".question")
	      content: "All of the questions will be on a 1-6 or 1-7 scale."
	      expose: true
	      position: "n"
	    }
	    {
	      sel: $(".question")
	      content: "Don’t over think the questions. Pick<br/>the answer that first comes to mind."
	      expose: true
	      position: "n"
	      callback: ->
	        window.location = "/examples/activity"
	        return
	    }
	  ],
	    showNavigation: true
	    showCloseBox: true
	    delay: -1
	    animation: "fadeInUp"
	  )
	  trip.start()
	  return
	startTrip()

$('.examples.activity').ready ->
	window.startTrip = ->
	  trip = new Trip([
	    {
	      content: "Activities are the meat and bones<br/>behind making yourself happier."
	      position: "screen-center"
	    }
	    {
	      sel: $(".form")
	      content: "Each activity will have a task for you to do."
	      expose: true
	      position: "n"
	    }
	    {
	      sel: $(".form")
	      content: "In this example, it’s writing about<br/>something you’re grateful for."
	      expose: true
	      position: "n"
	    }
	    {
	      sel: $(".form")
	      content: "Consistency is more important than content,<br/>so write only as much as you want."
	      expose: true
	      position: "n"
	    }
	    {
	      sel: $(".form")
	      content: "If you can get your point across in one word, awesome!"
	      expose: true
	      position: "n"
	    }
	    {
	      sel: $(".form")
	      content: "You may be thinking \"What the heck do I write?\""
	      expose: true
	      position: "n"
	    }
	    {
	      sel: $("blockquote")
	      content: "That's why we added quotes for those<br/>that are motivated by wise, old people..."
	      expose: true
	      position: "n"
	    }
	    {
	      sel: $(".tips")
	      content: "...and tips for those who want direct advice."
	      expose: true
	      position: "n"
	    }
	    {
	      content: "Doing these sorts of activities as much as<br/>possible while keeping it fresh<br/>and exciting is the..."
	      position: "screen-center"
	    }
	    {
	      content: "...best way to boost your happiness. Remember<br/>not to do too many or you'll<br/>burn yourself out!"
	      position: "screen-center"
	      callback: ->
	        window.location = "/examples/profile_start"
	        return
	    }
	  ],
	    showNavigation: true
	    showCloseBox: true
	    delay: -1
	    animation: "fadeInUp"
	  )
	  trip.start()
	  return
	startTrip()

$('.examples.profile_start').ready ->
	window.startTrip = ->
	  trip = new Trip([
	    {
	      content: "When you first sign up, this is<br/>what your profile will look like."
	      position: "screen-center"
	    }
	    {
	      content: "What you want to do is totally up to you."
	      position: "screen-center"
	    }
	    {
	      sel: $(".free-options")
	      content: "You can either do your own thing<br/>by clicking on one of these buttons"
	      expose: true
	      position: "n"
	    }
	    {
	      sel: $(".next-step")
	      content: "or follow along with the suggested next step."
	      expose: true
	      position: "n"
	    }
	    {
	      content: "Well, that’s it for the tour! If you haven't done so<br/>yet, <a href='/signup'>sign up</a> by clicking the link at the top."
	      position: "screen-center"
	    }
	    {
	      content: "Remember, if you have any questions, click the <i class=\"fa fa-question-circle fa-lg\"></i>"
	      position: "screen-center"
	    }
	    {
	      content: "If you have any feedback, check the Help section."
	      position: "screen-center"
	    }
	    {
	      content: "Stay awesome and be happy!<br/><small>—Happs</small>"
	      position: "screen-center"
	      callback: ->
	        window.location = "/signup"
	        return
	    }
	  ],
	    showNavigation: true
	    showCloseBox: true
	    delay: -1
	    animation: "fadeInUp"
	  )
	  trip.start()
	  return
	startTrip()
