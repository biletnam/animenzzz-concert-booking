$(function () {
    $('.nav-bar-profile-show-btn').on('click', function () {
        $('.nav-bar-profile-menu-cont').toggleClass('nav-bar-profile-menu-active');
    });
});

$(function () {
	if ($('.nav-msg').length) {
		setTimeout(function () {
			$('.nav-msg').fadeOut('slow');
		}, 1000 * 10);

		$('.nav-msg button').on('click', function (e) {
			$(e.currentTarget).parent('.nav-msg').fadeOut('slow'); });
	}
});
