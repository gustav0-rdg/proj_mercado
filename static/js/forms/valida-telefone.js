const inputTelefone = document.querySelector('#telefone');
inputTelefone.addEventListener('input', ()=>{
    let valor = inputTelefone.value.replace(/[^0-9]/g, '');
    if (valor.length > 3){
        valor =  '('+valor.slice(0, 2)+')' + valor.slice(2,11);
    }
    
    if(valor.length > 7){
        valor = valor.slice(0,9) +'-'+valor.slice(9, 14);
    }
    inputTelefone.value = valor.slice(0,14);
})