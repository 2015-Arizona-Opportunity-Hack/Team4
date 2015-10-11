//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require libs/bootstrap
//= require libs/select2
//= require libs/bootstrap-multiselect
//= require libs/moment
//= require libs/daterangepicker

$(document).ready(function(){
    _reports = {}
    _reports.fetch = function(){
        params = {}
        params.branch = $('.branch').val();
        params.date = $('.daterangepicker').val();
        var xmlRequest = $.ajax({
            url: 'filters/get_data',
            type:"GET",
            dataType: "json",
            data: params
        });
        return xmlRequest;
    };
    _reports.report = function() {
        var _i = {};
        var options = {};
        var start_date, end_date;
        _i.init_date = function () {
            start_date = moment().subtract("months", 3).format("DD/MM/YYYY");
            end_date = moment().format("DD/MM/YYYY");
            options = {
                startDate: start_date,
                endDate: end_date,
                ranges: {
                    'Today': [moment(), moment()],
                    'Yesterday': [moment().subtract('days', 1), moment().subtract('days', 1)],
                    'Last 7 Days': [moment().subtract('days', 6), moment()],
                    'Last 30 Days': [moment().subtract('days', 29), moment()],
                    'This Month': [moment().startOf('month'), moment().endOf('month')],
                    'Last Month': [moment().subtract('month', 1).startOf('month'), moment().subtract('month', 1).endOf('month')]
                }
            }
            _i.xAxis = {range: 30 * 24 * 3600 * 1000};
        }

        _i.process = function(){
            html = '<table class="table table-hover">\
                <tr>\
                <th width="20%">Phone</th>\
                <th width="20%">Email</th>\
                <th width="20%" class="actions">Actions</th>\
                </tr>';
            for (x=0; x<_i.data.length; x++) {
                var element = _i.data[x];
                console.log(element);
                html += '<tr>\
                     <td>'+element.phone+'</td>\
                    <td>'+element.email+'</td>\
                        <td class="actions">\
                            <a href="http://localhost:3000/volunteers/'+element._id.$oid+'" class="btn btn-small btn-success">More info</a>\
                        </td>\
                    </tr>';
            }
            html += '</table>';
            $('.report').html(html);
        };

        _i.generate = function () {
            _reports.fetch().done(function (one, two, three) {
                try {
                    _i.data = one;
                    console.log(_i.data);
                    _i.process();
                } catch (e) {
                    console.log(e);
                }
            });
        }
        _i.generate();
    }


    var date_options = {
        format: 'DD/MM/YYYY',
        startDate: moment().subtract("days", 30).format("DD/MM/YYYY"),
        endDate: moment().format("DD/MM/YYYY"),
        ranges: {
            'Today': [moment(), moment()],
            'Yesterday': [moment().subtract('days', 1), moment().subtract('days', 1)],
            'Last 7 Days': [moment().subtract('days', 6), moment()],
            'Last 30 Days': [moment().subtract('days', 29), moment()],
            'This Month': [moment().startOf('month'), moment().endOf('month')],
            'Last Month': [moment().subtract('month', 1).startOf('month'), moment().subtract('month', 1).endOf('month')]
        },
        opens: "left"
    }

    $('.daterangepicker').daterangepicker(date_options);

    $('.generate').click(function(e){
        _reports.report();
    });
});