// Toggle Reply button
$('.comment').each(function() {
  var $button = $(this).find('> .reply');
  var $form = $(this).find('> .reply-form');
  $button.on('click', function() {
     $form.toggleClass('hidden');
  });
});
