describe('propagation', function () {
    it('should not propagate a click down', function () {
        var event = {type: 'click', stopPropagation: function () {
            }},
            a = $("<a/>"),
            spy = spyOn(event, "stopPropagation");

        a.on('click', function (e) {
            e.stopPropagation();
        });

        a.addClass('dropdown-menu');

        //drop_down_ready();

        a.trigger('click', event);
        a.trigger(event);

        console.debug("post click");

        //expect(e.preventDefault).toHaveBeenCalled();
        expect(spy).toHaveBeenCalled();
    });
});