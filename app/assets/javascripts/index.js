$(function () {
    $('.nav-bar-profile-show-btn').on('click', function () {
        $('.nav-bar-profile-menu-cont').toggleClass('nav-bar-profile-menu-active');
    });
});

$(function () {
	if ($('.top-msg').length) {
		setTimeout(function () {
			$('.top-msg').fadeOut('slow');
		}, 1000 * 10);

		$('.top-msg button').on('click', function (e) {
			$(e.currentTarget).parent('.top-msg').fadeOut('slow'); });
	}
});
