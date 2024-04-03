<script>
import FontIcon from "./FontIcon.svelte";

</script>

<div class="relative text-xl h-[100%] w-[100%] tracking-widest">
  <h1 style="font-family: 'Supermercado One', cursive;" class="text-center text-5xl py-5">COLIS & Co.</h1>

  <div class="mt-20">
    <a class="flex items-center p-3 transition hover:text-[#C1DDB4]" href="./"><FontIcon icon="magnifying-glass" texte="Rechercher"></FontIcon></a>
    <a class="flex items-center p-3 transition hover:text-[#C1DDB4]" href="./"><FontIcon icon="basket-shopping" texte="Mon Panier"></FontIcon></a>
    <a class="flex items-center p-3 transition hover:text-[#C1DDB4]" href="./"><FontIcon icon="box" texte="Mes Commandes"></FontIcon></a>
  </div>

  <div class="absolute bottom-0 w-[100%]">
    <div class="text-right border-[#C1DDB4] border p-2 my-3 rounded-xl">39 pts</div>
    <a class="flex items-center transition hover:text-[#C1DDB4] p-3" href="./"><FontIcon icon="user" texte="Mon Compte"></FontIcon></a>
  </div>
</div>