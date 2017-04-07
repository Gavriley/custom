$('#sort_fields').sortable({
  cursor: 'move',
  stop: function() { recount_fields(); }
});

function recount_fields() {
  return $('#sort_fields .form-group:visible #order').each(function(index) {
    $(this).val(++index);
  });
}

$('#sort_fields').on('click', '#destroy_field', function(event) {

  var _destroy = $(this).parent().find('#_destroy')

  if(_destroy.length) {
    $(this).parent().hide();
    _destroy.val(true);
  }else {
    $(this).parent().remove();
  }

  recount_fields();
  event.preventDefault();
});

// Roles functions

$('#add_role').click(function(event) {
  var value = $('input[name=role_value]').val();
  var index = $('#_role_index').val();

  if(value.length && index.length) $.post($('#add_role').attr('url'), { value: value, index: index });
  $('input[name=role_value]').val('');
  event.preventDefault();
});

$('#sort_roles').sortable({
  cursor: 'move',
  stop: function() { recount_role_fields(); }
});

function recount_role_fields() {
  return $('#sort_roles .role-item:visible #role_order').each(function(index) {
    $(this).val(++index);
  });
}

$('#sort_roles').on('click', '#destroy_role', function(event) {
  var _destroy = $(this).parent().find('#_destroy')

  if(_destroy.length) {
    $(this).parent().hide();
    _destroy.val(true);
  }else {
    $(this).parent().remove();
  }

  recount_role_fields();
  event.preventDefault();
});
