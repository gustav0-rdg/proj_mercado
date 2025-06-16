document.addEventListener('DOMContentLoaded', () => {
    const btnComentario = document.querySelector('.filme__rate-btn');
    const filmeID = document.querySelector('#filmeId').value;
    const comentarioHTML = `
        <form action="/add/comentario/${filmeID}" method="post" id="form__comentario">
            <h3>Avalie o filme</h3>
            <label for="avaliacao">Avaliação:</label>
            <textarea type="text" name="comentario" id="avaliacao" class="form__comentario-input"></textarea>
            <label for="nota">Nota:</label>
            <input type="number" name="avaliacao" id="nota" class="form__comentario-input" min="1" max="5" step="1.0">
            <button class="form__comentario-btn">Enviar comentário</button>
        </form>
    `;

    btnComentario.addEventListener('click', () => {
        Swal.fire({
            html: comentarioHTML,
            showConfirmButton: false,
            width: '300px', // Faz o SweetAlert ocupar toda a largura disponível
            padding: '0',  // Remove o padding extra
            customClass: {
                popup: 'full-width-popup'  // Classe personalizada para customização
            }
        });
        document.querySelector('#form__comentario').addEventListener('submit', (e)=>{
            e.preventDefault
        });
    });
});