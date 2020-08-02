$(document).on('turbolinks:load', function () {
    $('#question').on('click', '.edit-question-link', function (e) {
        e.preventDefault();
        $(this).hide();
        $('form#edit-question').removeClass('hidden');
    });

    $('#question .rate-actions').on("click",".rate-up", function (e) {
        e.preventDefault();
        $(this).addClass('hidden');
        $('#question .rate-actions .rate-down:first').addClass('hidden');

        $('#question .rate-actions .rate-cancel:first').removeClass('hidden');
    });

    $('#question .rate-actions').on("click",".rate-down", function (e) {
        e.preventDefault();
        $(this).addClass('hidden');
        $('#question .rate-actions .rate-up:first').addClass('hidden');

        $('#question .rate-actions .rate-cancel:first').removeClass('hidden');
    });

    $('#question .rate-actions').on("click",".rate-cancel", function (e) {
        e.preventDefault();
        $(this).addClass('hidden');

        $('#question .rate-actions .rate-up:first').removeClass('hidden');
        $('#question .rate-actions .rate-down:first').removeClass('hidden');
    });

    $('#question .rate-actions').on('ajax:success', function (e) {
        difference = e.detail[0].difference;

        $('#question .rate-value:first').html(difference)
    });
});