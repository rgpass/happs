$('.pafds.new').ready(function() {

var selectTags = $('select')
var numberOfQuestions = selectTags.length;

updateButton(selectedCount());

$('select').on('change', function() {
	setTimeout(function() {
		updateButton(selectedCount());
	}, 250);
});

function updateButton(selected) {
	if (selected < numberOfQuestions) {
		$('input[type=submit]').val(selected + " of " + numberOfQuestions + " answered");
	} else {
		$('input[type=submit]').val("All Done").attr('disabled',false);
	}
}

function selectedCount() {
	var selectedCount = 0;
	for (var i = 0; i < selectTags.length; i++) {
		if (selectTags[i].value != "0") {
			selectedCount++;
		}
	}
	return selectedCount;
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
      content: "When you've answered all<br/>the questions, click here<br/>to continue.",
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
