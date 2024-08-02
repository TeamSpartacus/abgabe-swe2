window.onload = function () {
  let resData = {};
  let xhr = new XMLHttpRequest();
  xhr.open(
    "GET",
    "https://informatik.hs-bremerhaven.de/docker-swe2-2024-team06-web/cgi-bin/backend/handler.sh?action=show_allDevice",
    true
  );
  xhr.send();
  xhr.onload = function () {
    if (xhr.status != 200) {
      console.log(xhr.status + ": " + xhr.statusText);
    } else {
      xhr.responseText.split("\n").forEach((element) => {
        let device = element.split(";");
        let deviceItemList = [];
        for (let i = 0; i < device.length; i++) {
          deviceItemList.push(device[i]);
        }
        resData[device[0]] = deviceItemList;
      });
      delete resData[""];
      console.log(resData);

      let resDataKeys = Object.keys(resData);
      delete resData[resDataKeys[resDataKeys.length - 1]];
      console.log(resData);

      let table = document.getElementById("tablebody");

      let indexNumbers = [1, 8, 13, 14];
      for (let key in resData) {
        let row = table.insertRow(-1);
        for (let i = 0; i < indexNumbers.length; i++) {
          let cell = row.insertCell(i);
          cell.innerHTML =
            "<a href='https://informatik.hs-bremerhaven.de/docker-swe2-2024-team06-web/swe2-project/src/html/show_device.html?a=" +
            resData[key][0] +
            "'>" +
            resData[key][indexNumbers[i]] +
            "</a>";
        }
      }
    }
  };
};
