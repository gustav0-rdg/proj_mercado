const selectFilme = document.querySelector('#selectFilme');
const tituloFilme = document.querySelector('#edit_titulo');
const selectCatPrincipal = document.querySelector('#categoria_principal');
const selectCatSecundaria = document.querySelector('#categoria_secundaria');

const sinopseEdit = document.querySelector('#edit_sinopse');
const precoEdit = document.querySelector('#edit_preco');
const img1Edit = document.querySelector('#edit_img1');
const img2Edit = document.querySelector('#edit_img2');

const titulo = document.querySelector('#addTitulo');
const selectCat1 = document.querySelector('#addselectCategoria1');
const selectCat2 = document.querySelector('#addselectCategoria2');
const sinopse = document.querySelector('#addSinopse');
const preco = document.querySelector('#addPreco');
const img1 = document.querySelector('#addImg1');
const img2 = document.querySelector('#addImg2');

let categoriasCache = []; // Evita refazer fetch em cada change

addEventListener('DOMContentLoaded', async () => {
    try {
        // Carrega filmes
        let response = await fetch("/view/filmes");
        if (response.ok) {
            const filmes = await response.json();
            filmes.forEach(filme => {
                const option = document.createElement('option');
                option.value = filme.id_filme;
                option.textContent = filme.nome_filme;
                selectFilme.appendChild(option);
            });
        }

        // Carrega categorias e salva em cache
        response = await fetch("/view/categorias");
        if (response.ok) {
            categoriasCache = await response.json();

            categoriasCache.forEach(categoria => {
                const opt1 = document.createElement('option');
                opt1.value = categoria.id_categoria;
                opt1.textContent = categoria.categoria;

                const opt2 = opt1.cloneNode(true);

                selectCat1.appendChild(opt1);
                selectCat2.appendChild(opt2);
            });
        }
    } catch (error) {
        console.error('Erro ao carregar dados iniciais:', error);
    }
});

selectFilme.addEventListener('change', async () => {
    const filmeID = selectFilme.value;
    const deletaFilme = document.querySelector("#link_filme");
    const editFilme = document.querySelector('#editForm');
    editFilme.setAttribute('action', `/edit/filme/${filmeID}`)
    deletaFilme.setAttribute("href", `/delete/filme/${filmeID}`);

    if (!filmeID) return;

    try {
        const response = await fetch(`/view/filme/${filmeID}`);
        if (!response.ok) throw new Error("Erro ao buscar o filme");

        const filme = await response.json();

        // Preenche campos
        tituloFilme.value = filme.nome_filme;
        sinopseEdit.value = filme.sinopse;
        precoEdit.value = filme.preco;
        img1Edit.value = filme.img_1 || '';
        img2Edit.value = filme.img_2 || '';

        // Limpa e repopula categorias apenas 1x
        selectCatPrincipal.innerHTML = '<option value="">-- Selecione uma categoria --</option>';
        selectCatSecundaria.innerHTML = '<option value="">-- Selecione uma categoria --</option>';

        categoriasCache.forEach(categoria => {
            const opt1 = document.createElement('option');
            opt1.value = categoria.id_categoria;
            opt1.textContent = categoria.categoria;
            if (categoria.categoria === filme.categoria) opt1.selected = true;
            selectCatPrincipal.appendChild(opt1);

            const opt2 = document.createElement('option');
            opt2.value = categoria.id_categoria;
            opt2.textContent = categoria.categoria;
            if (categoria.categoria === filme.sub_categoria) opt2.selected = true;
            selectCatSecundaria.appendChild(opt2);
        });

    } catch (error) {
        console.error("Erro ao carregar dados do filme:", error);
    }
});
