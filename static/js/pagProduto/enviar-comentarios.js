const btnComentario = document.querySelector('.filme__rate-btn');

const comentarioHTML = `
    <form action="/add/carrinho/{{filme.id_filme}}" method="post">
`;

btnComentario.addEventListener('click', ()=>{
    Swal.fire({
        title:'oi',
        text:'o samuel cucuzinho',
        icon:'error'
    })
})