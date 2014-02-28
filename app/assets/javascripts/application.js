// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//
//= require turbolinks
//= require jquery
//= require jquery_ujs
//= require jquery.tree.js
//= require bootstrap
//= require bootstrap-datepicker/core
//= require bootstrap-datepicker/locales/bootstrap-datepicker.zh-CN
//= require_tree .



$(function(){

    $('body').on('change', '.region_select', function(event) {
        var self, $targetDom;
        self = $(event.currentTarget);
        if(!self.data('region-target-kalss')) return
        $id = self.attr('id');
        $targetDom = $('#' + $id.substring(0,$id.lastIndexOf('_')+1)+self.data('region-target-kalss'));
        if ($targetDom.size() <= 0) {
            $targetDom = $('#' + $id.replace("province",self.data('region-target-kalss')));
        }

        if ($targetDom.size() > 0) {
            $.getJSON('/china_region_fu/fetch_options', {klass: self.data('region-target-kalss'), parent_klass: self.data('region-klass'), parent_id: self.val()}, function(data) {
                var options = [];
                $('option[value!=""]', $targetDom).remove();
                $.each(data, function(index, value) {
                    options.push("<option value='" + value.id + "'>" + value.name + "</option>");
                });
                $targetDom.append(options.join(''));
            });
        } else {

        }
    });

    $(document).on('ready page:load', function () {
        
        $('.datepicker').datepicker({
            format:     'yyyy-mm-dd',
            autoclose:  true,
            language:   'zh-CN'
        });

        $('#money_button .controls').on('click','a',function(e){
            if($.isNumeric($(e.target).text())) {
                $('#phone_total').val($(e.target).text());
            }
            else{
                $('#phone_total').attr('readonly',false).val('').focus();
            }
        })

        if($('#phone_obj').size()>0){
            var query_button = $('<a class="btn">').text('查询');
            $('#phone_obj').parent().append(query_button);
            query_button.on('click',function(e){
                $('#phone_info').addClass('hide');
                $('#phone_info .controls').empty();
                $.get( "/locations/query?number="+$('#phone_obj').val(), function( data ) {
                    if(typeof data != 'string'){
                        $('#phone_info .controls').empty();
                        $('#phone_info .controls').append($('<span>').addClass('alert alert-success').text("姓名:"+data.name))
                        $('#phone_info .controls').append($('<span>').addClass('alert alert-success').text("余额:"+data.balance))
                        $('#phone_info').removeClass('hide')
                    }
                });
            })
        }

        $('#phone_obj').on('change',function(e){
            $('#money_button').addClass('hide');
            $('#remark_div').addClass('hide');
            $('#phone_location').val('');
            $('#phone_total').attr('readonly',true).val('');
            $('#phone_remark').val('');
            $.get( "/locations/search?number="+e.target.value, function( data ) {
                if(typeof data != 'string'){
                    $('#phone_location').val(data.location.city+' '+ data.location.isp);
                    $('#money_button').removeClass('hide')
                    denominations = data.channel.denomination.split(',');
                    $('#money_button .controls').empty();
                    var small  = $('<span class="well">');//.append('小面值:')
                    var large = $('<span class="well">');//.append('大面值:')
                    for (d in denominations){
                        if(parseInt(denominations[d])>100){
                            large.append($('<a class="btn">').val(denominations[d]).text(denominations[d]));
                        }
                        else{
                            small.append($('<a class="btn">').val(denominations[d]).text(denominations[d]));
                        }
                    }
                    $('#money_button .controls').append(small).append(large);
                    $('#money_button .controls').append($('<input type="hidden" name="phone[channel_id]">').val(data.channel.id));
                    if(data.channel.business=='1'){
                        $('#remark_div').removeClass('hide');
                        $('#phone_remark').val(data.channel.remark);
                    }
                    // $('#money_button .controls')
                }
            });
        });
    });

});
/*
 document.addEventListener("page:load", selector_onload);
 */
