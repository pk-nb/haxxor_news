# Toggle Reply
$(".comment-content").each ->
  $this = $(this)
  $button = $this.find("> .reply")
  $form = $this.find("> .reply-form")
  $button.on "click", ->
    $form.toggleClass "hidden"

$ ->
  $(".votes a[data-remote]").on "ajax:success", (e, data, status, xhr) ->
    $this = $(this)
    votes_container = $this.parent(".votes")
    score = $this.siblings('.score')

    # Update score and class on vote change
    unless data.vote == "not_logged_in" || data.vote == "error"
      score.text(data.newScore)
      votes_container.removeClass("upvoted downvoted destroyed").addClass(data.vote)
