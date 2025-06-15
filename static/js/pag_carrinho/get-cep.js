const inputCep = document.querySelector("#cep");
const buscaCep = document.querySelector('#buscarCep');
inputCep.addEventListener('input', () => {
    let valor = inputCep.value.replace(/[^0-9]/g, '');

    if (valor.length > 5) {
        valor = valor.slice(0, 5) + '-' + valor.slice(5, 8);
    }

    inputCep.value = valor.slice(0, 9);

    if (valor.length === 9) { // 8 números + 1 tracinho
        buscaCep.disabled = false;
        document.querySelector('#salvarCep').disabled = false;
    } else {
        buscaCep.disabled = true;
        document.querySelector('#salvarCep').disabled = true;
    }
});

buscaCep.addEventListener('click', async ()=>{
    const response = await fetch(`https://viacep.com.br/ws/${inputCep.value}/json/`);
    const data = await response.json()
    if (data){
        console.log(data);
    }
})
