myClass = document.getElementsByClassName("header-logo");
console.log(myClass);
for (let index = 0; index < myClass.length; ++index) {
  let element = myClass[index];
  element.addEventListener("click", function (e) {
    window.location.href = "main.html";
  });
}
