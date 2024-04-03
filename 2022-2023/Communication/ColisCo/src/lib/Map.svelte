<script>
  import * as L from 'leaflet';
  import "leaflet/dist/leaflet.css"

  function createMap(container) {
      var map = L.map(container, {
          center: [46.5,2],
          zoom: 6
      });
      let attrib = '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors'

      //layer2 :https://cartodb-basemaps-{s}.global.ssl.fastly.net/light_all/{z}/{x}/{y}.png
      L.tileLayer('https://{s}.basemaps.cartocdn.com/rastertiles/voyager/{z}/{x}/{y}{r}.png',{attribution: attrib, subdomains: 'abcd'}).addTo(map);
  }

</script>

<div class="w-[100%] h-[100%] z-0" use:createMap/>