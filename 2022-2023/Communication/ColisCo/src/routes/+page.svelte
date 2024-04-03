<script>
    import Map from "$lib/Map.svelte";
    import Menu from "$lib/Menu.svelte";
    import Search from "$lib/Search.svelte";

	import '../app.css';

</script>

<svelte:head>
    <title></title>
    <meta name="description" content="">    
</svelte:head>

<div class="w-[100vw] h-[100vh] p-5 bg-[#1E3E2E] grid-cols-2 grid gap-5" style="grid-template-columns: 300px 1fr;">
    <Menu></Menu>

    <div class="p-5 bg-white text-[#1E3E2E] rounded-3xl">
        <div class="relative h-[100%] overflow-hidden rounded-3xl">
            <Search ></Search>
            <Map></Map>
        </div>        
    </div>

    
</div>