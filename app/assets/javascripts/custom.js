$(function () {
    date_format = "MMMM Do, YYYY"
    x = $('#fine_days').val()

    $('#datetimepicker_start').datetimepicker({
        format: date_format,
        defaultDate: moment($('#first_day').attr("value")),
    });
    $('#datetimepicker_end').datetimepicker({
        format: date_format,
        defaultDate: $('#last_day').attr("value")
    });
    $('#datetimepicker_fine1').datetimepicker({
        format: date_format,
        defaultDate: $('#fine_days').attr("value")
    });
    $('#first_day').val(moment($('#first_day').attr("value")).format(date_format))
    $('#last_day').val(moment($('#last_day').attr("value")).format(date_format))
    $('#fine_days').val(moment($('#fine_days').attr("value")).format(date_format))
});

console.log("Custom Loaded");