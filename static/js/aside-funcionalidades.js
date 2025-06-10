// Menu Toggle
const menuToggle = document.getElementById('menuToggle');
const aside = document.getElementById('aside');
const asideOverlay = document.getElementById('asideOverlay');

function openaside() {
    aside.classList.add('aside--open');
    asideOverlay.classList.add('aside__overlay--active');
    document.body.style.overflow = 'hidden';
}

function closeaside() {
    aside.classList.remove('aside--open');
    asideOverlay.classList.remove('aside__overlay--active');
    document.body.style.overflow = 'auto';
}

menuToggle.addEventListener('click', openaside);
asideOverlay.addEventListener('click', closeaside);

// Aside fechando ao apertar ESC
document.addEventListener('keydown', (evento) => {
    if (evento.key === 'Escape' && aside.classList.contains('aside--open')) {
        closeaside();
    }
});