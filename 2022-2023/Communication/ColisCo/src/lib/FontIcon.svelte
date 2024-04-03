<script>


  export let icon
  export let texte
</script>

<div>
  <div class="inline-block align-middle">
    <i class="w-12 h-12 fa-2xl fa-solid fa-{icon}" style="display:grid;place-items: center;"></i>
  </div>
  <p class="inline-block align-middle ml-3">{texte}</p>
</div>