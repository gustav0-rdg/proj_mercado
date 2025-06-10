document.addEventListener('DOMContentLoaded', async function () {
    try {
        const codigoAside = await fetch('/aside');
        const codigoAsideFuncionalidades = await fetch('/asideFuncionalidades')
        console.log(codigoAside);
        console.log(codigoAsideFuncionalidades);
        if (!codigoAside.ok || !codigoAsideFuncionalidades.ok) {
            throw new Error('Arquivo não encontrado no servidor.');
        }

        const aside = await codigoAside.text();
        document.querySelector('.aside__container').innerHTML = aside;

        const asideFuncionalidades = await codigoAsideFuncionalidades.text();
        document.getElementById('aside__funcionalidades').innerHTML = asideFuncionalidades;

    }
    catch (error) {
        console.error('Erro ao carregar o aside:', error);
    }
    
});