document.addEventListener('DOMContentLoaded', async function(){
    try {
        // 1. Fazer a requisição
        const response = await fetch("/carrinho"); // Use rota local, não externa
        console.log('Response status:', response.status);
        
        // 2. Verificar se a resposta é válida
        if (!response.ok) {
            throw new Error(`Erro HTTP: ${response.status}`);
        }
        
        // 3. Converter para JSON (não apenas verificar se existe)
        const data = await response.json();
        console.log('Dados recebidos:', data);
        
        // 4. Verificar se o container existe
        const itensList = document.querySelector(".carrinho__itens");
        if (!itensList) {
            console.error('Container .carrinho__itens não encontrado');
            return;
        }
        
        // 5. Verificar se há dados e se é um array
        if (data && Array.isArray(data) && data.length > 0) {
            // Limpar conteúdo anterior
            itensList.innerHTML = '';
            // 6. Iterar corretamente pelos itens
            data.forEach(element => {
                // Criar um elemento para cada item (não sobrescrever)
                let item = document.createElement('article') 
                item.classList.add('carrinho__item');
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
                        
                        <button class="carrinho__item-remover">
                            <i class="fas fa-trash"></i>
                        </button>
                `;
                itensList.appendChild(item);
            });
        } else {
            // Carrinho vazio
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
        
        // Mostrar erro para o usuário
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
