$('.ohqs.new').ready(function() {

var numberOfQuestions = $('label').length / 6;

$('label').on('click', function() {
	setTimeout(function() {
		updateButton($('label.active').length);
	}, 250);
});

function updateButton(selectedCount) {
	if (selectedCount < numberOfQuestions) {
		$('input[type=submit]').val(selectedCount + " of " + numberOfQuestions + " answered");
	} else {
		$('input[type=submit]').val("All Done").attr('disabled',false);
	}
}

window.startTrip = function() {
  var trip;
  trip = new Trip([
    {
      sel: $(".info"),
      content: "Important info about<br/>the questionnaire.",
      expose: true,
      position: "n"
    }, {
      sel: $(".questions"),
      content: "Answer each question.<br/>Don't think about it too hard.",
      expose: true,
      position: "n"
    }, {
      sel: $("input[type=submit]"),
      content: "When you've answered all the<br/>questions, click here to continue.",
      expose: true,
      position: "e"
    }
  ], {
    showNavigation: true,
    showCloseBox: true,
    delay: -1,
    animation: "fadeInUp"
  });
  trip.start();
};

});
