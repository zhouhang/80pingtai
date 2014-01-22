
$(function(){
    $(document).foundation();
    $(document).bind('ajax:success', function(evt, data, status, xhr){
        alert('操作成功');
        Turbolinks.visit(location.href)
    });
    $(document).ajaxError(function(event, request, settings) {
        alert('操作失败');
    })
})

//    document.addEventListener("page:fetch", my_ready);