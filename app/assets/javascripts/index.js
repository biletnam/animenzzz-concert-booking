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

$(function () {
    $('#link-delete-order').on('click', function (e) {
        if (window.confirm('确定要取消该订单么？')) {
            $.ajax({
                type: 'DELETE',
                url: e.currentTarget.getAttribute('data-action')
            }).always(function () {
                window.location.href = e.currentTarget.getAttribute('data-redirect');
            });
        }
    });
});
