window.onload = async function () {
  document
    .getElementById("login-form")
    .addEventListener("submit", async function (event) {
      event.preventDefault();
      let email = document.getElementById("email").value;
      let password = document.getElementById("password").value;

      const encoder = new TextEncoder();
      const passwordBuffer = encoder.encode(password);
      const hashBuffer = await crypto.subtle.digest("SHA-256", passwordBuffer);
      const hashArray = Array.from(new Uint8Array(hashBuffer));
      const hashHex = hashArray
        .map((b) => b.toString(16).padStart(2, "0"))
        .join("");
      console.log(hashHex);

      let requestString =
        "https://informatik.hs-bremerhaven.de/docker-swe2-2024-team06-web/cgi-bin/backend/login.sh?email=" +
        encodeURIComponent(email) +
        "&pwdHash=" +
        encodeURIComponent(hashHex);

      fetch(requestString)
        .then((response) => response.json())
        .then((data) => {
          console.log(data);
          if (data.status == 200) {
            //Cookies Setzten
            alert("Login successful \nWelcome " + data.uuid);
          } else {
            alert("Login failed: " + data.status);
          }
        });
    });
};
