setInterval(()=>{
    const imagens = document.querySelectorAll('.active');
    imagens.forEach(img =>{
        let indexImg = img.getAttribute('data-index');
        if (indexImg == 1){
            let cardTrocado = document.querySelectorAll('[data-index="2"]');
            cardTrocado.forEach(e =>{
                e.classList.add('active');
                img.classList.remove('active');
            })
        } else{
            let cardTrocado = document.querySelectorAll('[data-index="1"]');
            cardTrocado.forEach(e =>{
                e.classList.add('active');
                img.classList.remove('active');
            })         
        }
    }) 

}, 4000)