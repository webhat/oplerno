describe('propagation', function () {
    it('should not propagate a click down', function () {
        var event = {type: 'click', stopPropagation: function () {
            }},
            a = $("<a id='authy-help'/>"),
            spy = spyOn(event, "stopPropagation");

        $('body').append(a);

        window.authy_help();

        a.trigger('click', event);
        a.trigger(event);

        expect(spy).toHaveBeenCalled();
    });
});
