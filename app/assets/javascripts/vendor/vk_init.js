document.addEventListener("turbolinks:load", function(){
  VK.init({apiId: 5343503, onlyWidgets: true});
  var url = $("#share-data").attr("data-url");
  $("a.vk").html(VK.Share.button(url,{type: "round", text: "share", eng: 1}));
});
