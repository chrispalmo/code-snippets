const canvas = document.getElementById("id");
const data = canvas.toDataURL("image/png");
const newWindow = window.open("about:blank", "image from canvas");
newWindow.document.write("<img src='" + data + "' alt='from canvas'/>");
