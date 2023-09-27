document.addEventListener("turbolinks:load", function() {
  $('.travels-prefecture').off('click').click(function () {
    $(this).next('.set-travels-area').slideToggle();
    $(this).toggleClass('close');
    scrollToTitleImageArea($(this));
  });

  $('.close-button').off('click').on('click', function() {
    $(this).closest('.set-travels-area').slideToggle();
    scrollToTitleImageArea($(this));
  });
  
  function scrollToTitleImageArea(element) {
    const target = element.closest('.title-image-area');
    $('html, body').animate({
      scrollTop: target.offset().top
    }, 500, function() {
      target.addClass('blinking');
      setTimeout(() => {
        target.removeClass('blinking');
      }, 2000);
    });
  }
});
