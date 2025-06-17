document.addEventListener('DOMContentLoaded', () => {
const currentTheme = localStorage.getItem('theme') || 'light';
document.body.classList.add(currentTheme);
}) 



