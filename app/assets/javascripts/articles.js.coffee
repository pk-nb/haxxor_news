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
    # Find what class I am
    # Assign myself and opposite vote
    $this = $(this)
    this_direction = $this
    opposite_direction = $this.siblings('.vote')
    score = $this.siblings('.score')
    console.log "newLink", data.newLink

    switch data.method
      when "create", "update"
        # console.log "Hi from create/update"
        this_direction.attr("data-method", "delete")
        opposite_direction.attr("data-method", "put")
      else
        this_direction.attr("data-method", "post")
        opposite_direction.attr("data-method", "post")


    score.text(data.newScore)

    # console.log this
    # console.log opposite_direction
    # console.log score
    # if :create
    #   turn myself into destroy
    #   turn opposite into edit

    # else if :destroy
    #   turn both into :create

    # else if :edit
    #   turn myself into :destory
    #   turn opposite into :edit

    # update score

    console.log data
    console.log status
    console.log xhr.responseText
    # $(this).siblings('.up').prop("data-method") (i, value) ->
    #   return "junk"

$ ->
  $(".votes a[data-remote]").on "ajax:error", (e, xhr, status) ->
    console.log xhr.responseText
    console.log status
