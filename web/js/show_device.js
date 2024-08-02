window.onload = function () {
  const args = new URLSearchParams(window.location.search);
  reserve(args.get("a"));
  let deviceItemList;
  let xhr = new XMLHttpRequest();
  xhr.open(
    "GET",
    "https://informatik.hs-bremerhaven.de/docker-swe2-2024-team06-web/cgi-bin/backend/handler.sh?action=show_device&a=" +
      args.get("a"),
    true
  );
  xhr.send();
  xhr.onload = function () {
    if (xhr.status != 200) {
      console.log(xhr.status + ": " + xhr.statusText);
    } else {
      let counter = 0;
      xhr.responseText.split("\n").forEach((element) => {
        let device = element.split(";");
        if (counter == 1) {
          deviceItemList = device;
        }
        counter++;
      });

      let table = document.getElementById("tablebody");
      let row = table.insertRow(0);
      for (let i = 0; i < deviceItemList.length; i++) {
        let cell = row.insertCell(i);
        cell.innerHTML = deviceItemList[i];
      }
    }
  };
};

async function reserve(id) {
  document
    .getElementById("reserve-form")
    .addEventListener("submit", async function (event) {
      event.preventDefault();
      let location = document.getElementById("location").value;
      let res_start = document.getElementById("res-start").value;
      let res_end = document.getElementById("res-end").value;

      let requestString =
        "https://informatik.hs-bremerhaven.de/docker-swe2-2024-team06-web/cgi-bin/backend/handler.sh?action=get_device_status&id=" +
        id;

      let responsePromise = await fetch(requestString);
      let response = (await responsePromise.text()).split("\n")[1].toString();
      if (response === "0") {
        reserveDevice({
          id: id,
          location: location,
          res_start: res_start,
          res_end: res_end,
          res_user: 1, //Testzwecke muss durch die UUID ersetzt werden, mit der der Benutzer eingeloggt ist
        });
        alert("Device reserved");
        window.location.href =
          "https://informatik.hs-bremerhaven.de/docker-swe2-2024-team06-web/swe2-project/src/html/table_devices.html";
      } else {
        alert("Device is already reserved");
      }
    });
}

async function reserveDevice(params) {
  let requestString =
    "https://informatik.hs-bremerhaven.de/docker-swe2-2024-team06-web/cgi-bin/backend/handler.sh?action=reserve_device&id=" +
    params.id.split(" ") +
    "&location=" +
    params.location +
    "&res_start=" +
    params.res_start +
    "&res_end=" +
    params.res_end +
    "&res_user=" +
    params.res_user;
  fetch(requestString);
}
