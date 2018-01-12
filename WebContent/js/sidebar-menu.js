;(function ($, window, document, undefined) {
    if ($('ul.sidebar-menu').length) {
        var collapsed = true;
        var close_same_level = false;
        var duration = 400;
        var listAnim = true;
        var easing = 'easeOutQuart';
        $('.sidebar-menu ul').css({
            'overflow': 'hidden',
            'height': collapsed ? 0 : 'auto',
            'display': collapsed ? 'none' : 'block'
        });
        var node = $('.sidebar-menu li:has(ul)');
        node.each(function (index, val) {
            $(this).children(':first-child').css('cursor', 'pointer');
            $(this).addClass('mtree-node mtree-' + (collapsed ? 'closed' : 'open'));
            $(this).children('ul').addClass('mtree-level-' + ($(this).parentsUntil($('ul.sidebar-menu'), 'ul').length + 1));
        });
        $('.sidebar-menu li > *:first-child').on('click.menu-active', function (e) {
            if ($(this).parent().hasClass('mtree-closed')) {
                $('.menu-active').not($(this).parent()).removeClass('menu-active');
                $(this).parent().addClass('menu-active');
            } else if ($(this).parent().hasClass('mtree-open')) {
                $(this).parent().removeClass('menu-active');
            } else {
                $('.menu-active').not($(this).parent()).removeClass('menu-active');
                $(this).parent().toggleClass('menu-active');
            }
        });
        node.children(':first-child').on('click.mtree', function (e) {
            var el = $(this).parent().children('ul').first();
            var isOpen = $(this).parent().hasClass('treeview-active');
            if ((close_same_level || $('.csl').hasClass('active')) && !isOpen) {
                var close_items = $(this).closest('ul').children('.treeview-active').not($(this).parent()).children('ul');
                if ($.Velocity) {
                    close_items.velocity({ height: 0 }, {
                        duration: duration,
                        easing: easing,
                        display: 'none',
                        delay: 100,
                        complete: function () {
                            setNodeClass($(this).parent(), true);
                        }
                    });
                } else {
                    close_items.delay(100).slideToggle(duration, function () {
                        setNodeClass($(this).parent(), true);
                    });
                }
            }
            el.css({ 'height': 'auto' });
            if (!isOpen && $.Velocity && listAnim)
                el.find(' > li, li.treeview-active > ul > li').css({ 'opacity': 0 }).velocity('stop').velocity('list');
            if ($.Velocity) {
                el.velocity('stop').velocity({
                    height: isOpen ? [
                        0,
                        el.outerHeight()
                    ] : [
                        el.outerHeight(),
                        0
                    ]
                }, {
                    queue: false,
                    duration: duration,
                    easing: easing,
                    display: isOpen ? 'none' : 'block',
                    begin: setNodeClass($(this).parent(), isOpen),
                    complete: function () {
                        if (!isOpen)
                            $(this).css('height', 'auto');
                    }
                });
            } else {
                setNodeClass($(this).parent(), isOpen);
                el.slideToggle(duration);
            }
            e.preventDefault();
        });
        function setNodeClass(el, isOpen) {
            if (isOpen) {
                el.removeClass('mtree-open').addClass('mtree-closed');
            } else {
                el.removeClass('mtree-closed').addClass('mtree-open');
            }
        }
        if ($.Velocity && listAnim) {
            $.Velocity.Sequences.list = function (element, options, index, size) {
                $.Velocity.animate(element, {
                    opacity: [
                        1,
                        0
                    ],
                    translateY: [
                        0,
                        -(index + 1)
                    ]
                }, {
                    delay: index * (duration / size / 2),
                    duration: duration,
                    easing: easing
                });
            };
        }
        if ($('.sidebar-menu').css('opacity') == 0) {
            if ($.Velocity) {
                $('.sidebar-menu').css('opacity', 1).children().css('opacity', 0).velocity('list');
            } else {
                $('.sidebar-menu').show(200);
            }
        }
    }
}(jQuery, this, this.document));