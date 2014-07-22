# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(".users.show").ready ->
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

$('.users.new').ready ->
	window.startTrip = ->
	  trip = new Trip([
	    {
	      sel: $("#user_first_name, label[for=\"user_first_name\"]")
	      content: "Required. Max length of 20 characters."
	      expose: true
	      position: "e"
	    }
	    {
	      sel: $("#user_last_name, label[for=\"user_last_name\"]")
	      content: "Required. Max length of 30 characters."
	      expose: true
	      position: "e"
	    }
	    {
	      sel: $("#user_email, label[for=\"user_email\"]")
	      content: "Required. Valid email address."
	      expose: true
	      position: "e"
	    }
	    {
	      sel: $("#user_password, label[for=\"user_password\"]")
	      content: "Required. Min length of 6 characters."
	      expose: true
	      position: "e"
	    }
	    {
	      sel: $("#user_password_confirmation, label[for=\"user_password_confirmation\"]")
	      content: "Required. Must be the same."
	      expose: true
	      position: "e"
	    }
	    {
	      sel: $(".create")
	      content: "When finished, click to here create your account."
	      expose: true
	      position: "e"
	    }
	  ],
	    showNavigation: true
	    showCloseBox: true
	    delay: -1
	    animation: "fadeInUp"
	  )
	  trip.start()
	  return

$('.users.edit').ready ->
	window.startTrip = ->
	  trip = new Trip([
	    {
	      sel: $("#user_first_name, label[for=\"user_first_name\"]")
	      content: "Required. Max length of 20 characters."
	      expose: true
	      position: "e"
	    }
	    {
	      sel: $("#user_last_name, label[for=\"user_last_name\"]")
	      content: "Required. Max length of 30 characters."
	      expose: true
	      position: "e"
	    }
	    {
	      sel: $("#user_email, label[for=\"user_email\"]")
	      content: "Required. Valid email address."
	      expose: true
	      position: "e"
	    }
	    {
	      sel: $("#user_password, label[for=\"user_password\"]")
	      content: "Required to save any changes. Can be same as previous. Min length of 6 characters."
	      expose: true
	      position: "e"
	    }
	    {
	      sel: $("#user_password_confirmation, label[for=\"user_password_confirmation\"]")
	      content: "Required. Must be the same as Password field."
	      expose: true
	      position: "e"
	    }
	    {
	      sel: $(".update")
	      content: "When finished, click to here update your account."
	      expose: true
	      position: "e"
	    }
	    {
	      sel: $(".gravatar-link")
	      content: "Visit Gravatar's website to change your picture."
	      expose: true
	      position: "e"
	    }
	  ],
	    showNavigation: true
	    showCloseBox: true
	    delay: -1
	    animation: "fadeInUp"
	  )
	  trip.start()
	  return
