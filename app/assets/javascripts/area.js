
function createNode(){
var root = {
"id" : "0",
"text" : "root",
"value" : "86",
"showcheck" : true,
complete : true,
"isexpand" : false,
"checkstate" : 0,
"hasChildren" : true
};
var arr = [];
for(var i= 1;i<100; i++){
var subarr = [];
for(var j=1;j<100;j++){
var value = "node-" + i + "-" + j;
subarr.push( {
  "id" : value,
  "text" : value,
  "value" : value,
  "showcheck" : true,
  complete : true,
  "isexpand" : false,
  "checkstate" : 0,
  "hasChildren" : false
});
}
arr.push( {
  "id" : "node-" + i,
  "text" : "node-" + i,
  "value" : "node-" + i,
  "showcheck" : true,
  complete : true,
  "isexpand" : false,
  "checkstate" : 0,
  "hasChildren" : true,
  "ChildNodes" : subarr
});
}
root["ChildNodes"] = arr;
return root;
}

//var treedata = [createNode()];


$.ajax({
    type: "post",
    data:{},
    dataType:"json",
    url: "/admin/channles/get_provinces_cites",
    success: function(data, textStatus){
        var treedata = data.data;
        var o = { showcheck: true};
        o.data = treedata;
        $("#tree").treeview(o);
    },
    complete: function(XMLHttpRequest, textStatus){
        //HideLoading();
        //alert("complete"+textStatus);
    },
    error: function(){
        //请求出错处理
    }
});
$("#submit").click(function(e){
    var s=$("#tree").getCheckedNodes();
    if(s !=null){
        $("#channel_area").val(s.join(","));
        alert($("#channel_area").val());
    }else{
        alert("NULL");
    }
});
