function drop_down_ready() {
    $('.dropdown-menu').click(function (e) {
        e.stopPropagation();
    });
};

$(document).ready(function () {
    drop_down_ready();
});
