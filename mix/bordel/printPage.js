/*F12 to open console, run this, ctrl p t print, refresh*/
var elements = document.querySelectorAll(".overflow-hidden");
for (var i = 0; i < elements.length; i++) {
  elements[i].style.overflow = "visible";
}