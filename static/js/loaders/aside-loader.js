document.addEventListener('DOMContentLoaded', async function () {
    try {
        const codigoAside = await fetch('/aside');
        const codigoAsideFuncionalidades = await fetch('/asideFuncionalidades');

        if (!codigoAside.ok || !codigoAsideFuncionalidades.ok) {
            throw new Error('Arquivo não encontrado no servidor.');
        }

        const aside = await codigoAside.text();
        document.querySelector('.aside__container').innerHTML = aside;

        const asideFuncionalidades = await codigoAsideFuncionalidades.text();
        document.getElementById('aside__funcionalidades').innerHTML = asideFuncionalidades;

        aplicarToggleTema(); // <- Aplica o evento após o aside ser carregado
    } catch (error) {
        console.error('Erro ao carregar o aside:', error);
    }
});

function aplicarToggleTema() {
    const botaoTema = document.querySelector('.theme-toggle');
    const iconTema = document.getElementById('theme__icon');
    if (!botaoTema) return;

    const currentTheme = localStorage.getItem('theme') || 'light';
    document.body.classList.add(currentTheme);

    botaoTema.addEventListener('click', () => {
        if (document.body.classList.contains('dark')) {
            document.body.classList.remove('dark');
            // Muda o icon do tema
            iconTema.classList.remove('fa-moon');
            iconTema.classList.add('fa-sun');
            // Salva o estado no localStorage
            localStorage.setItem('theme', 'light');
        } else {
            document.body.classList.add('dark');
            // Muda o icon do tema
            iconTema.classList.remove('fa-sun');
            iconTema.classList.add('fa-moon');
            // Salva o estado no localStorage
            localStorage.setItem('theme', 'dark');
        }
    });
}