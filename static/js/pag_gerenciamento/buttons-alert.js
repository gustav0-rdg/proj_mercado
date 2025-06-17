const buttonSubmit = document.querySelector('#btnSubmit');
const buttonEdit = document.querySelector('#edit_link');
const buttonDelete = document.querySelector('#link_filme');

buttonSubmit.addEventListener('click', (event) =>{
    event.preventDefault();

    Swal.fire({
        icon: 'success',
        title: 'Filme adicionado!',
        text: 'O filme foi adicionado ao catálogo com sucesso.',
    }).then(() => {
        buttonSubmit.closest('form').submit()
    })
})

buttonEdit.addEventListener('click', (event) =>{
    event.preventDefault();

    const Toast = Swal.mixin({
        toast: true,
        position: "top-end",
        showConfirmButton: false,
        timer: 3000,
        timerProgressBar: true,
        didOpen: (toast) => {
          toast.onmouseenter = Swal.stopTimer;
          toast.onmouseleave = Swal.resumeTimer;
        }
      });
      Toast.fire({
        icon: "success",
        title: "As informações foram editadas"
      }).then(() =>{
        buttonEdit.closest('form').submit();
      })
} )

buttonDelete.addEventListener('click', (event) => {
    event.preventDefault();

    Swal.fire({
        title: 'Tem certeza?',
        text: 'Essa ação não poderá ser desfeita!',
        icon: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#d33',
        cancelButtonColor: '#3085d6',
        confirmButtonText: 'Sim, excluir!'
    }).then((result) => {
        if (result.isConfirmed) {

            const Toast = Swal.mixin({
                toast: true,
                position: "top-end",
                showConfirmButton: false,
                timer: 3000,
                timerProgressBar: true,
                didOpen: (toast) => {
                  toast.onmouseenter = Swal.stopTimer;
                  toast.onmouseleave = Swal.resumeTimer;
                }
              });

              
              window.location.href = buttonDelete.getAttribute('href');
              Toast.fire({
                icon: "success",
                title: "O filme foi excluído com sucesso!"
              })
            }
    });
});