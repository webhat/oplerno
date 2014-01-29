describe('propagation', function () {
    it('should not propagate a click down', function () {
        var event = {
                type: 'click',
                stopPropagation: function () {
                }
            },
            div = $('div'),
            a = $('a'),
            spy = spyOn(event, 'stopPropagation');

        a.appendTo(div);

        a.addClass('dropdown-menu');

        drop_down_ready();

        $('.dropdown-menu').trigger(event);
        expect(spy).toHaveBeenCalled();
    });
});