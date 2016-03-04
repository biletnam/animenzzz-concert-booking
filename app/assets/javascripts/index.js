$(function () {
    $('.nav-bar-profile-show-btn').on('click', function () {
        $('.nav-bar-profile-menu-cont').toggleClass('nav-bar-profile-menu-active');
    });
    
    var seatCount = 0;
    var MAX_SEAT_COUNT = 4;
    $('.seat > input[type="checkbox"]').change(function (e) {
        if (e.target.checked == true) {
            seatCount++;
        } else {
            seatCount--;
        }
        if (seatCount >= MAX_SEAT_COUNT) {
            $('.seat > input[type="checkbox"]:not(:checked)').addClass('seat-disabled');
        } else {
            $('.seat > input[type="checkbox"]').removeClass('seat-disabled');
        }
        
        $('.seat-count').text(seatCount.toString());
    });
});
