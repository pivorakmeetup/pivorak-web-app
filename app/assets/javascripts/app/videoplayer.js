(function () {
    document.querySelectorAll('.js-video-link').forEach(function(item) {item.addEventListener('click', openVideo)});

    function createLightbox() {
        var lightbox = document.createElement('div');

        var lightboxCloseButton = document.createElement('a');

        function closeLightbox () {
            lightboxCloseButton.removeEventListener('click', closeLightbox);

            document.getElementsByTagName('body')[0].removeChild(lightbox)

            document.querySelector('body').style.overflow = null;
        }

        lightboxCloseButton.appendChild(document.createTextNode('X'));

        lightboxCloseButton.className = 'pk-video-container__close';

        lightboxCloseButton.addEventListener('click', closeLightbox);

        lightbox.className = 'pk-video-container';

        lightbox.appendChild(lightboxCloseButton);

        document.querySelector('body').appendChild(lightbox);

        document.querySelector('body').style.overflow = "hidden";
    }

    function openVideo(e) {
        e.preventDefault();

        var href = e.currentTarget.getAttribute('href');

        if (!document.querySelector('.pk-video-container')) {
            createLightbox();
        }

        var iframe = document.createElement("iframe");

        var videoId = href.slice(href.indexOf('?v=')+3, href.length);

        iframe.setAttribute("src",
            "https://www.youtube.com/embed/" + videoId
            + "?autoplay=1&autohide=1&border=0&wmode=opaque&enablejsapi=1");

        iframe.setAttribute('allowfullscreen', 'allowfullscreen')


        document.querySelector('.pk-video-container').appendChild(iframe)
    }
})();
