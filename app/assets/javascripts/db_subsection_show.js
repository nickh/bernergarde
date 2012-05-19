$(document).ready(function() {
  function showSubsection(subsection) {
    if (subsection == '' || $(subsection + '.subsection').length == 0) {
      subsection = '#' + $('.subsection')[0].id;
    }

    $('.subsection').not(subsection).hide();
    $('.subsection_nav').not('a[href='+subsection+']').removeClass('active');
    $('.subsection_nav').has('a[href='+subsection+']').addClass('active');
    $(subsection).show();
    document.location.hash = subsection.substr(1);
  };

  $('.subsection_nav a').click(function() {
    showSubsection(this.hash);
  });

  showSubsection(document.location.hash);
});
