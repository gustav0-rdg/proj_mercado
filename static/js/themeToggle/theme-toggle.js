document.addEventListener('DOMContentLoaded', ()=>{
    const currentTheme = localStorage.getItem('theme')|| 'light';
    document.body.classList.add(currentTheme);
    document.querySelector('.theme-toggle').addEventListener('click', ()=>{
        if (document.body.classList.contains('dark')){
            document.body.classList.toggle('dark');
            localStorage.setItem('theme', 'light');
        } else {
            document.body.classList.toggle('dark');
            localStorage.setItem('theme', 'dark');
        }
    })
})