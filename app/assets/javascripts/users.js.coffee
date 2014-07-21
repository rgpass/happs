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
