const senha = document.querySelector('#senha');
const repSenha = document.querySelector('#repSenha');
const btnCadastrar = document.querySelector('.btn__cadastrar');

function validarSenha() {
    if (senha.value === repSenha.value && senha.value.length > 4) {

        btnCadastrar.disabled = false;
    } else {
        btnCadastrar.disabled = true;
    }
}

senha.addEventListener('input',function(){
    validarSenha()
} );
repSenha.addEventListener('input', function(){
    validarSenha()
});