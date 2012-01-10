//= require jquery
//= require jquery_ujs
//= require_self
//= require_tree .

$('a[data-popup]').live('click', function(e) {
   window.open($(this)[0].href);
   e.preventDefault();
});
