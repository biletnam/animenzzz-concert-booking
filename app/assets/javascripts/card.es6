
"use strict";

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
		// this._bindScroll();
		this._bindTouch();
        
        this.dataArray = [ ];
        for (var i = 0; i < this.numElements; i++) {
            this.dataArray.push(i); }
        
        this.updateStyle();
	}
    
    CardFlow.prototype.updateStyle = function () {
        var indexElement = idx => $(this.element).children('.coverflow-item').get(idx);
        
        this.dataArray.forEach((elementIndex, index) => {
            if (!index) {
                $(indexElement(elementIndex)).css({
					'transform': 'none',
					'z-index': this.numElements
				}).addClass('coverflow-item-active');;
            } else {
                var scale = getScale(index);
				var offsetTranslate = index * 20;
                var transformTranslate = 'translate3d(' + offsetTranslate + '%, 0, ' + -index * 20 + 'px)',
					translateScale = 'scale3d(' + scale + ', ' + scale + ', 1)',
					translateRotate = `rotateY(${-index * 3}deg)`;
                $(indexElement(elementIndex)).css({
					'transform': `${transformTranslate} ${translateRotate} ${translateScale}`,
					'z-index':  (this.numElements - index)
				}).removeClass('coverflow-item-active');
            }
        });
    };

	CardFlow.prototype.slideOffset = function(offset) {
        var currentIdx = this.dataArray[0];
		var idx = this.dataArray[offset];
        
        if (currentIdx !== idx) {
            this.dataArray.splice(offset, 1);
            this.dataArray.splice(0, 1);
            this.dataArray.unshift(idx);
            this.dataArray.push(currentIdx);
            this.updateStyle();
        }
	};
    
    CardFlow.prototype.slideTo = function(index) {
        return this.slideOffset(this.dataArray.indexOf(index));
	};

	CardFlow.prototype.slidePrev = function () {
        var offset = this.dataArray.length-1;
		var idx = this.dataArray[offset];
        this.dataArray.splice(offset, 1);
        this.dataArray.unshift(idx);
        this.updateStyle();
	};

	CardFlow.prototype.slideNext = function () {
		this.slideOffset(1);
	};

	CardFlow.prototype._bindClick = function () {
		$(this.element).children('.coverflow-item').children('.coverflow-content').each((index, element) =>
			$(element).click(() => this.slideTo(index))
        );
	};

	CardFlow.prototype._bindScroll = function () {
		$(this.element).on('wheel',
			debounce(e => {
				var delta = e.originalEvent.wheelDelta || -e.originalEvent.detail;

				if (delta < -10 && delta < 3) {
					return;
				} else if (delta < 0) {
					this.slideNext();
				} else if (delta > 0) {
					this.slidePrev();
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