// todo fix when have full site search
// document.addEventListener("turbolinks:load", highlight);
// $(document).ajaxComplete(highlight);
//
// function highlight(){
//   var el = $("[data-id='listings']");
//   var term = el.data("term");
//   var html = el.html();
//
//   if(!!term && !!html) {
//     $.each(term.split(" "), function(i, word){
//       var regex = new RegExp(word, "gi");
//       html = html.replace(regex, "<mark>"+word+"</mark>");
//     });
//     el.html(html);
//   }
// }
