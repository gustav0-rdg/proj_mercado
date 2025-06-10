// document.addEventListener('DOMContentLoaded', async function(){
//     const data = await fetch("https://disco-magico.onrender.com/carrinho");
//     console.log(data);
//     if(data){
//         const itensList = document.querySelector(".carrinho__itens");
//         data.forEach(element => {
//             itensList.innerHTML = `${element.nome_filme}`;
//         });
//     }
// })