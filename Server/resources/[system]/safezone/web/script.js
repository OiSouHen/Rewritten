window.addEventListener('message', function(event) {
    let data = event.data;
    if (event.data.type == 'show') {
        $(".square").html(data.texto);
        $("body").fadeIn();
    }

    if (event.data.type == 'hide') {
        $("body").fadeOut();
    }
});
