const nome = document.querySelector('.input__cadastro-name');
const usuario = document.querySelector('.input__cadastro-usuario');
const senha = document.querySelector('#senha');
const repSenha = document.querySelector('#repSenha');
const btnCadastrar = document.querySelector('.btn__cadastrar');

let nomeEscrito = false;
let usuarioEscrito = false;
let senhasIguais = false

function habilitarBtnCadastro() {
    if (nomeEscrito && usuarioEscrito && senhasIguais) {
        btnCadastrar.disabled = false;
        btnCadastrar.classList.remove('btn__cadastrar--disabled');
    }
    else {
        btnCadastrar.disabled = true;
        btnCadastrar.classList.add('btn__cadastrar--disabled');
    }
}

// Validação dos campos de nome e usuario
function validarCampo(campo) {
    // Ve se o campo e nome ou usuario e se há algo escrito nele
    if (campo === nome) {
    
        if (nome.value) {
            nomeEscrito = true;
        }
        else {
            nomeEscrito = false;
        }
    } 
    else if(campo === usuario){
     
        if (usuario.value) {
            usuarioEscrito = true;
        }
        else {
            usuarioEscrito = false;
        }
    }
    habilitarBtnCadastro();
}

nome.addEventListener('input',function(){
    validarCampo(nome)
} );
usuario.addEventListener('input',function(){
    validarCampo(usuario)
} );


// Validação da senha e confirmação de senha
function validarSenha() {
    if (senha.value === repSenha.value && senha.value.length > 4) {

        senhasIguais = true;
        habilitarBtnCadastro();
    } else {
        senhasIguais = false;
        habilitarBtnCadastro();
    }
}

senha.addEventListener('input',function(){
    validarSenha()
} );
repSenha.addEventListener('input', function(){
    validarSenha()
});