# Toggle Reply
$(".comment").each ->
  $this = $(this)
  $button = $this.find("> .reply")
  $form = $this.find("> .reply-form")
  $button.on "click", ->
    $form.toggleClass "hidden"
    return
  return

$ ->
  $(".votes a[data-remote]").on "ajax:success", (e, data, status, xhr) ->
    $this = $(this)
    votes_container = $this.parent(".votes")
    score = $this.siblings('.score')

    # Update score and class on vote change
    score.text(data.newScore)
    votes_container.removeClass("upvoted downvoted destroyed").addClass(data.vote)

$ ->
  $(".votes a[data-remote]").on "ajax:error", (e, xhr, status) ->
    console.log xhr.responseText
    console.log status
