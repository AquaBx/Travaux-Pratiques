function show(id) {
  document.getElementById("div1").classList.remove("div-active");
  document.getElementById("btn1").classList.remove("btn-active");

  document.getElementById("div2").classList.remove("div-active");
  document.getElementById("btn2").classList.remove("btn-active");

  document.getElementById("div3").classList.remove("div-active");
  document.getElementById("btn3").classList.remove("btn-active");

  document.getElementById("btn" + id).classList.add("btn-active");
  document.getElementById("div" + id).classList.add("div-active");
}

j = 0;
function convert(id) {
  if (j < 1) {
    for (i = 0; i < 1; i++) {
      var input = document.getElementById(id).innerHTML;
      var output = "";
      for (i = 0; i < input.length; i++) {
        var vbin = input[i].charCodeAt(0).toString(2);
        while (vbin.length < 8) {
          vbin = "0" + vbin;
        }
        output += vbin + " ";
      }
      document.getElementById(id).innerHTML = output;
    }
  } else if ((j = 1)) {
    for (i = 0; i < 1; i++) {
      var input = document.getElementById(id).innerHTML;
      var output = "";

      input = input.replace(/[^01]/g, "");
      binlength = input.length - (input.length % 8);
      for (z = 0; z < binlength; z = z + 8) {
        output += String.fromCharCode(parseInt(input.substr(z, 8), 2));
      }
      document.getElementById(id).innerHTML = output;
    }
  }
}
function boucle() {
  if (j < 1) {
    j += 1;
  } else {
    j = 0;
  }
}
