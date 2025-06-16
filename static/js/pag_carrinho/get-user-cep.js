const cepValue = document.querySelector('#cep')
const cidade = document.querySelector('#cidade');
const logradouro = document.querySelector('#logradouro');
const bairro = document.querySelector('#bairro');
const estado = document.querySelector('#estado');

document.addEventListener('DOMContentLoaded',async ()=>{
    const response = await fetch("/endereco");
    if (response.status == 200){
        const data = await response.json();
        if (data.erro){
            return;
        }
        cepValue.value = data.cep
        cidade.value = data.cidade;
        bairro.value = data.bairro;
        logradouro.value = data.logradouro;
        estado.value = data.estado;

        document.querySelector('#salvarCep').disabled = true;
    }
})