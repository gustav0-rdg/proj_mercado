document.addEventListener('DOMContentLoaded', async function(){
    try {
        const response = await fetch("/carrinho"); 
        
        if (!response.ok) {
            throw new Error(`Erro HTTP: ${response.status}`);
        }
        
        const data = await response.json();
        
        const itensList = document.querySelector(".carrinho__itens");
        if (!itensList) {
            console.error('Container .carrinho__itens não encontrado');
            return;
        }
        
        if (data && Array.isArray(data) && data.length > 0) {
            itensList.innerHTML = '';
            const productCount = document.querySelector('.product__count');
            const value = document.querySelector('.product__price');
            let valorTotal = 0;
            let contagemProduto = 0;
            data.forEach(element => {
                let item = document.createElement('article') 
                item.classList.add('carrinho__item');
                valorTotal = valorTotal + element.preco * element.quantidade;
                contagemProduto += element.quantidade;
                productCount.textContent = `${contagemProduto}`;
                value.textContent = `R$ ${valorTotal.toLocaleString('pt-BR', { minimumFractionDigits: 2 })}`;
                item.innerHTML = `
                        <img src="${element.img_1}" alt="${element.nome_filme}" class="carrinho__item-imagem">
                        
                        <div class="carrinho__item-info">
                            <h3 class="carrinho__item-titulo">${element.nome_filme}</h3>
                            
                            <div class="carrinho__item-avaliacao">
                                
                            </div>
                            
                            <div class="carrinho__item-preco">
                                Preço do filme:<br>
                                R$ ${element.preco}
                            </div>
                        </div>
                        
                        <div class="carrinho__item-quantidade">
                            ${element.quantidade}x
                        </div>
                        
                        <a class="carrinho__item-remover" href="/excluir/item/${element.id_carrinhoItens}">
                            <i class="fas fa-trash"></i>
                        </a>
                `;
                itensList.appendChild(item);
            });
        } else {
            itensList.innerHTML = `
                <div class="">
                    <h4>Carrinho Vazio</h4>
                    <p class="">Adicione alguns filmes ao seu carrinho!</p>
                    <a href="/catalogo" class="">Ver Catálogo</a>
                </div>
            `;
        }
        
    } catch (error) {
        console.error('Erro ao carregar carrinho:', error);
        
        const itensList = document.querySelector(".carrinho__itens");
        if (itensList) {
            itensList.innerHTML = `
                <div>
                    <h5>Erro ao carregar carrinho</h5>
                    <p>Tente novamente mais tarde.</p>
                </div>
            `;
        }
    }
});
