function updateNotificationArea() {
  const pageId = $(".top").data("page-id");
  const travelplanId = $(".top").data("travelplan-id");
  if (typeof pageId !== 'undefined') { 
      $.ajax({
        url: "/users/" + pageId,
        type: 'GET',
        dataType: 'json',
        headers: {
          'Accept': 'application/json'
      },
      success: function(response) {
        if (response.job_status === "completed") {
          $('.loading-bar').css('animation-play-state', 'paused').css('width', '100%');
          $.ajax({
            url: `/users/${pageId}/update_job_status`,
            type: 'PATCH',
            dataType: 'json',
            beforeSend: function(xhr) {
              xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'));
            },
          });
          $.ajax({
            url: `/travelplans/${travelplanId}/set_in_progress`,
            type: 'POST',
            dataType: 'json',
            beforeSend: function(xhr) {
              xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'));
            },
          });
          localStorage.setItem("showFlashAfterReload", "true");
          location.reload();
        } else {
          if ($('.loading-bar').width() >= $('.loading-bar').parent().width() * 0.85) {
            $('.loading-bar').css('animation-play-state', 'paused');
          }
          setTimeout(function() {
            updateNotificationArea();
          }, 3000);
        }
      },
    });
  }
};

document.addEventListener("turbolinks:load", function() {
  const previousTravelPlanId = localStorage.getItem("travelplanId");
  const currentTravelPlanId = $(".top").data("travelplan-id");
  const modalElement = document.getElementById('editModalshow');
  let editModalShow;
  if (modalElement) {
    editModalShow = new bootstrap.Modal(modalElement);
  }
  const tabs = $(".tab");
  tabs.off("click").on("click", function() {
    $(".active").removeClass("active");
    $(this).addClass("active");
    const index = tabs.index(this);
    $(".content").removeClass("show").eq(index).addClass("show");
  });
  updateNotificationArea();
  $('.editpage').off("click").on('click', function() {
    editModalShow.show();
  });
  $('.btn-close').off("click").on('click', function() {
    editModalShow.hide();
  });
  const showFlashAfterReload = localStorage.getItem("showFlashAfterReload");
  if (showFlashAfterReload) {
    const flashMessageContent = "旅行プランが作成されました";
    const flashElement = `<div id="flash-message" class="px-3 flash-message bg-warning">${flashMessageContent}</div>`;
    $("header").after(flashElement);
    localStorage.removeItem("showFlashAfterReload");
  }
});
