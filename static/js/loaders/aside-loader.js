document.addEventListener('DOMContentLoaded', async function () {
    try {
        const codigoAside = await fetch('/aside');
        console.log(codigoAside);

        if (!codigoAside.ok) {
            throw new Error('Arquivo não encontrado no servidor.');
        }

        const aside = await codigoAside.text();
        document.querySelector('.aside__container').innerHTML = aside;

    }
    catch (error) {
        console.error('Erro ao carregar o aside:', error);
    }
});