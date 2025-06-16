document.addEventListener('DOMContentLoaded', async function () {
    try {
        const codigoHeader = await fetch('/header');

        if (!codigoHeader.ok) {
            throw new Error('Arquivo não encontrado no servidor.');
        }

        const header = await codigoHeader.text();
        document.querySelector('.header__container').innerHTML = header;

    }
    catch (error) {
        console.error('Erro ao carregar o header:', error);
    }
});


