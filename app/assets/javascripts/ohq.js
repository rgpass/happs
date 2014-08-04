$('.ohq.new').ready(function() {

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

});
