// Toggle hidden class
// var comments = document.querySelectorAll(".comment");
// console.log(replyButtons);
// for(var i = 0, l = comments.length; i < l; i++) {
//   (function() {
//     var button = comments[i].querySelector(".reply");
//     var form = comments[i].querySelector(".reply-form");
//     button.addEventListener('click', function() {
//       form.classList.toggle("hidden");
//     });
//   })();
// }

// Toggle Reply button
$('.comment').each(function() {
  var $button = $(this).find('> .reply');
  var $form = $(this).find('> .reply-form');
  $button.on('click', function() {
     $form.toggleClass('hidden');
  });
});
