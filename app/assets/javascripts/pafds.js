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

var selectedCount = function() {
	var selectedCount = 0;
	for (var i = 0; i < selectTags.length; i++) {
		if (selectTags[i].value != "0") {
			selectedCount++;
		}
	}
	return selectedCount;
}

});
