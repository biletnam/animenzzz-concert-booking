(function ($) {

	function debounce(func, threshold) {
		var timeout;

		return function () {
			var that = this, args = arguments;

			if (timeout) {
				clearTimeout(timeout);
			}

			timeout = setTimeout(function () {
				func.apply(that, args);
				timeout = null;
			}, threshold);
		};
	}

	function getScale(offsetAbs) {
		var base = 0.6;
		var factor = 1;
		var offset = 0.5;
		return factor * (base + (1.0 / (offsetAbs + offset)) * (1 - base));
	}

	function CardFlow(element) {
		this.element = element;
		this.currentIndex = 0;
		this.numElements = $(element).children('.coverflow-item').length;

		this._bindClick();
		this._bindScroll();
		this._bindTouch();
		this.switchTo(0);
	}

	CardFlow.prototype.slideOffset = function(offset) {
		var offseted = this.currentIndex + offset;
		if (offseted < 0) {
			offseted += this.numElements;
		} else if (offseted >= this.numElements) {
			offseted -= this.numElements;
		}
		this.switchTo(offseted);
	};

	CardFlow.prototype.slidePrev = function () {
		this.slideOffset(-1);
	};

	CardFlow.prototype.slideNext = function () {
		this.slideOffset(1);
	};

	CardFlow.prototype.switchTo = function(to) {
		var that = this;
		$(this.element).children('.coverflow-item').each(function (index, element) {
			if (index !== to) {
				var offsetRaw = index - to, offsetAbs = Math.abs(offsetRaw);
				var sign = (offsetRaw > 0) ? '' : '-';

				var scale = getScale(offsetAbs);
				var offsetTranslate = offsetAbs * 30;
				// we do need template string
				var transformTranslate = 'translate3d(' + sign + offsetTranslate + '%, 0, ' + -offsetAbs * 20 + 'px)',
					translateScale = 'scale3d(' + scale + ', ' + scale + ', 1)',
					translateRotate = 'rotateY(' + -offsetRaw * 3 + 'deg)';

				$(element).css({
					'transform': `${transformTranslate} ${translateRotate} ${translateScale}`,
					// 'transform': transformTranslate + ' ' + translateScale + ' ' + translateRotate,
					'z-index':  (that.numElements - Math.abs(offsetRaw))
				}).removeClass('coverflow-item-active');
			} else {
				$(element).css({
					'transform': 'none',
					'z-index': that.numElements
				}).addClass('coverflow-item-active');;
			}
		});
		this.currentIndex = to;
	};

	CardFlow.prototype._bindClick = function () {
		var that = this;
		$(this.element).children('.coverflow-item').children('.coverflow-content').each(function (index, element) {
			$(element).click(function () {
				that.switchTo(index); });
		});
	};

	CardFlow.prototype._bindScroll = function () {
		var that = this;
		$(this.element).on('wheel',
			debounce(function (e) {
				var delta = e.originalEvent.wheelDelta || -e.originalEvent.detail;

				if (delta < -10 && delta < 3) {
					return;
				} else if (delta < 0) {
					that.slideNext();
				} else if (delta > 0) {
					that.slidePrev();
				}
			}, 20)
		);
	};

	CardFlow.prototype._bindTouch = function () {
		var that = this;

		var startX, startY;
		var offsetX, offsetY;
		function touchStart(e) {
			e.stopImmediatePropagation();

			startX = e.touches[0].pageX, startY = e.touches[0].pageY;
			offsetX = offsetY = 0;

			window.addEventListener('touchmove', touchMove, true);
			window.addEventListener('touchend', touchEnd, true);
		}

		function touchMove(e) {
			e.stopImmediatePropagation();
			offsetX = e.touches[0].pageX - startX, offsetY = e.touches[0].pageY - startY;
			
			if (Math.abs(offsetY) > Math.abs(offsetX)) {
				window.removeEventListener('touchmove', touchStart, true);
				window.removeEventListener('touchend', touchEnd, true);
			}
		}

		function touchEnd(e) {
			e.stopImmediatePropagation();

			window.removeEventListener('touchmove', touchStart, true);
			window.removeEventListener('touchend', touchEnd, true);

			if (offsetX < -50) {
				that.slideNext();
			} else if (offsetX > 50) {
				that.slidePrev();
			} else {
				return;
			}
			e.preventDefault();
		}

		this.element.addEventListener('touchstart', touchStart);
	};

	$.fn.cardFlow = function() {
		this.data('plugin_cardFlow', new CardFlow(this.get(0)));
	};
})(jQuery);