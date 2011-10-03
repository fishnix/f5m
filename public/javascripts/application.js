// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
$('a[data-popup]').live('click', function(e) {
   window.open($(this)[0].href);
   e.preventDefault();
});
