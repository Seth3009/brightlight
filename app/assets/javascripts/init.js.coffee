window.App ||= {}

App.init = ->
  $('select[data-dynamic-selectable-url][data-dynamic-selectable-target]').dynamicSelectable()

$(document).on "ready page:load", ->
  App.init()

# send get forms through turbolinks
$(document).on "submit", "form[method=get]", ->
  Turbolinks.visit(this.action+(if this.action.indexOf('?') == -1 then '?' else '&')+$(this).serialize())
  false

$(document).on 'ajax:complete', '.delete-link', ->
  $(this).closest("tr").remove()
  Materialize.toast($(this).data("message"), 4000, "green")

$(document).on 'click', '.delete-record', ->
  $(this).closest("tr").hide()
    .find("[name$='[_destroy]']").val(true)

$(document).on 'ajax:complete', '.delete-badge', ->
  $(this).parent().html("")
  Materialize.toast "Badge removed", 4000, "green"

 # The following callback function will turn select elements in the dynamically created row 
# into MaterializeCSS style selects.
$(document).on 'cocoon:after-insert', ->
  $('select').material_select()


