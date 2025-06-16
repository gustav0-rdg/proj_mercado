const inputCep = document.querySelector("#cep");
const buscaCep = document.querySelector('#buscarCep');

const inputCidade = document.querySelector('#cidade');
const inputLogradouro = document.querySelector('#logradouro');
const inputBairro = document.querySelector('#bairro');
const inputEstado = document.querySelector('#estado');

const Toast = Swal.mixin({
    toast: true,
    position: "top-end",
    showConfirmButton: false,
    timer: 3000,
    timerProgressBar: true,
    didOpen: (toast) => {
        toast.onmouseenter = Swal.stopTimer;
        toast.onmouseleave = Swal.resumeTimer;
    }
});

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
    const cepValue = document.querySelector("#cep").value;
    const response = await fetch(`https://viacep.com.br/ws/${cepValue}/json/`);
    if (response.status == 200){
        const data = await response.json();
        if (data.erro){
            Toast.fire({
                title:'Erro na busca.',
                icon: 'error'
            })
            return;
        }
        Toast.fire({
            title:'Busca concluída com sucesso.',
            icon: 'success'
        })
        console.log(data);
        inputCidade.value = data.localidade;
        inputBairro.value = data.bairro;
        inputLogradouro.value = data.logradouro;
        inputEstado.value = data.estado;
    }
})
