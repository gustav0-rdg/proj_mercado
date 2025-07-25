document.addEventListener('DOMContentLoaded', async function () {
    try {
        const codigoFooter = await fetch('/footer');

        if (!codigoFooter.ok) {
            throw new Error('Arquivo não encontrado no servidor.');
        }

        const footer = await codigoFooter.text();
        document.querySelector('.footer__container').innerHTML = footer;

    }
    catch (error) {
        console.error('Erro ao carregar o footer:', error);
    }
});