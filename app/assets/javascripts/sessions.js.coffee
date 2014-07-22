# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$('.sessions.new').ready ->
	window.startTrip = ->
	  trip = new Trip([
	    {
	      sel: $("#session_email, label[for=\"session_email\"]")
	      content: "Type in the one you used to sign up."
	      expose: true
	      position: "e"
	    }
	    {
	      sel: $("#session_password, label[for=\"session_password\"]")
	      content: "Type in the one you used to sign up."
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
