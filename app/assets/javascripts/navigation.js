$(function() {
    // check whether to disable navigation links
    enableNavLinks();

    // assign click handler to navigation links
    $('#navPrev, #navNext').click(function() {
        submitForm($(this));
    })
});

function enableNavLinks() {
    // get current and last page numbers
    var currentPage = $('#page').val();
    var lastPage = $('#totalPages').val();

    // disable the appropriate navigation links if necessary
    if (currentPage == '0') {
        disableLink($('#navPrev'));
    } else if (currentPage == lastPage) {
        disableLink($('#navNext'));
    }
}

function disableLink($navLink) {
    $navLink.removeAttr('href');
    $navLink.click(function() {
        e.preventDefault();
    });
}

function submitForm($navLink) {
    // set the next page and submit form to get the next set of results
    setPage($navLink);
    $('#searchForm').submit();
}

function setPage($navLink) {
    var navId = $navLink.attr('id');
    var currentPage = parseInt($('#page').val(), 10);

    // determine the next page to set based on whether the previous or next link was clicked
    if (navId == 'navNext') {
        currentPage++;
    } else {
        currentPage--;
    }

    $('#page').val(currentPage);
}
