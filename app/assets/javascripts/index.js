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
    $('#link-delete-order, .link-delete-order').on('click', function (e) {
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

function createElementWithClassName(tagName, className) {
    tagName = tagName || 'div';
    className = className || '';
    var ret = document.createElement(tagName);
    ret.className = className;
    return ret;
}

function createModal(width, height, classname) {
    classname = classname || '';

    var overlay = createElementWithClassName('div', 'modal-overlay');

    var closeButton = createElementWithClassName('div', 'modal-overlay-close');
    closeButton.addEventListener('click', function closeModal (e) {
        document.body.style.overflow = 'auto';
        document.body.removeChild(overlay);
    });

    closeButton.appendChild(createElementWithClassName('i', 'fa fa-2x fa-close'));
    overlay.appendChild(closeButton);

    classname = classname ? ('modal ' + classname) : 'modal';
    var modalElement = createElementWithClassName('div', classname);
    if (width > 0 && height > 0) {
        $.extend(modalElement.style, {
            'width': width + 'px',
            'height': height + 'px',
            'margin-left': -width / 2 + 'px',
            'margin-top': -height / 2 + 'px'
        });
    }
    overlay.appendChild(modalElement);

    document.body.appendChild(overlay);
    document.body.style.overflow = 'hidden';

    return modalElement;
}
