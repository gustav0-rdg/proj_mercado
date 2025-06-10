document.addEventListener('DOMContentLoaded', async function(){
    const data = await fetch("https://disco-magico.onrender.com/carrinho")
    console.log(data)
})