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
//= require turbolinks
//= require jquery
//= require jquery_ujs
//= require jquery.tree.js
//= require foundation
//= require modernizr.js
//= require_tree .



$(function(){
    $('body').on('change', '.region_select', function(event) {
        var self, $targetDom;
        self = $(event.currentTarget);
        if(!self.data('region-target-kalss')) return
        $id = self.attr('id');
        $targetDom = $('#' + $id.substring(0,$id.lastIndexOf('_')+1)+self.data('region-target-kalss'));

        if ($targetDom.size() > 0) {
            $.getJSON('/china_region_fu/fetch_options', {klass: self.data('region-target-kalss'), parent_klass: self.data('region-klass'), parent_id: self.val()}, function(data) {
                var options = [];
                $('option[value!=""]', $targetDom).remove();
                $.each(data, function(index, value) {
                    options.push("<option value='" + value.id + "'>" + value.name + "</option>");
                });
                $targetDom.append(options.join(''));
            });
        }
    });
});
/*

document.addEventListener("page:load", selector_onload);
*/
