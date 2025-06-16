const selectFilme = document.querySelector('#selectFilme');
const tituloFilme = document.querySelector('#edit_titulo');

addEventListener('DOMContentLoaded', async () =>{
    try{
        const response = await fetch("/view/filmes");
        if (response.status === 200){

            const filmes = await response.json();

            if (filmes.erro){
                console.log('Erro na promise dos filmes!');
                return;
            } 
            
            filmes.forEach(filme => {
                const option = document.createElement('option');

                option.value = filme.id_filme;
                option.textContent = filme.nome_filme;
                selectFilme.appendChild(option);
            })
        } else{
            console.log('Erro ao buscar os filmes. Status: ', response.status);
        }

    }

    catch (error) {
        console.log('Erro na requisição: ', error);
    }
})

selectFilme.addEventListener('change', () =>{
    tituloFilme.textContent = 
})