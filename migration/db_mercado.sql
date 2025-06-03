		CREATE DATABASE IF NOT EXISTS db_mercado;
		USE db_mercado;

		CREATE TABLE tb_usuarios(
			id_usuario int auto_increment primary key,
			nome_usuario varchar(30) not null,
			usuario varchar(30) not null,
			cep varchar(14),
			telefone varchar(11) unique,
			email varchar(100) unique,
			senha varchar(64) not null
			);

		CREATE TABLE IF NOT EXISTS tb_categorias(
			id_categoria int auto_increment primary key,
			categoria varchar(30) not null
		);

		CREATE TABLE IF NOT EXISTS tb_filmes(
			id_filme int auto_increment primary key,
			nome_filme varchar(50) not null,
			sinopse text,
			preco float not null,
			id_categoria int not null,
			id_subgenero int,
			FOREIGN KEY (id_categoria) REFERENCES tb_categorias(id_categoria),
			FOREIGN KEY (id_subgenero) REFERENCES tb_categorias(id_categoria)
		);

		CREATE TABLE IF NOT EXISTS tb_fotos(
			id_foto int auto_increment primary key,
			id_filme int not null,
			img_1 text not null,
			img_2 text not null,
			img_banner text not null,
			FOREIGN KEY (id_filme) REFERENCES tb_filmes(id_filme)
		);

		CREATE TABLE tb_comentarios(
			id_comentario int auto_increment primary key,
			id_filme int not null,
			id_usuario int not null,
			avaliacao int not null,
			comentario text not null,
			data DATETIME default now(),
			FOREIGN KEY (id_filme) REFERENCES tb_filmes(id_filme),
			FOREIGN KEY (id_usuario) REFERENCES tb_usuarios(id_usuario)
		);

		CREATE TABLE tb_filmes_avaliacao(
			id_avaliacao int auto_increment primary key,
			id_filme int not null,
			id_comentario int not null,
			avaliacao int,
			FOREIGN KEY (id_filme) REFERENCES tb_filmes(id_filme),
			FOREIGN KEY (id_comentario) REFERENCES tb_comentarios(id_comentario)
		);

		CREATE TABLE IF NOT EXISTS tb_carrinho(
			id_carrinho int auto_increment primary key,
			id_usuario int not null,
			status_pedido varchar(50) not null,
			criado_em DATETIME DEFAULT now(),
			atualizado_em DATETIME,
			FOREIGN KEY (id_usuario) REFERENCES tb_usuarios(id_usuario)
			);
			
		CREATE TABLE IF NOT EXISTS tb_carrinho_itens(
			id_carrinhoItens int auto_increment primary key,
			id_carrinho int not null,
			id_filme int not null,
			quantidade int not null,
			preco DECIMAL(10,2) not null,
			adicionado_em datetime default now(),
			FOREIGN KEY (id_carrinho) REFERENCES tb_carrinho(id_carrinho),
			FOREIGN KEY (id_filme) REFERENCES tb_filmes(id_filme)
		);
			
		CREATE TABLE IF NOT EXISTS tb_pedido(
			id_pedido int auto_increment primary key,
			id_usuario int not null,
			id_carrinho int not null,
			data_pedido datetime,
			estado ENUM("PAGO", "PENDENTE", "CANCELADO", "ENTREGUE") not null,
			total DECIMAL(10,2) not null,
			FOREIGN KEY (id_carrinho) REFERENCES tb_carrinho(id_carrinho),
			FOREIGN KEY (id_usuario) REFERENCES tb_usuarios(id_usuario)
		);

		INSERT INTO tb_categorias(categoria)VALUES('Ação'),('Drama'),('Comédia'),('Terror'),('Suspense'),('Romance'),('Ficção Cíentifica'),('Fantasia'),('Infantil'),('Aventura'),
		('Documentário'),('Musical'),('Mistério');
		-- Filme
		INSERT INTO tb_filmes (nome_filme, preco, id_categoria, id_subgenero, sinopse)
		VALUES 
		('Shrek', 20.00, 3, 8, 'Shrek, um ogro solitário, tem sua vida interrompida quando criaturas de contos de fadas invadem seu pântano. Para recuperar sua paz, ele embarca em uma jornada para resgatar a princesa Fiona, fazendo um acordo com o Lorde Farquaad.'),

		('Barbie: Escola de Princesas', 17.99, 2, 9, 'Blair Willows, uma jovem garçonete, é aceita na prestigiosa Escola de Princesas de Gardênia. Lá, ela descobre que pode ser a herdeira desaparecida do reino, enfrentando desafios para reivindicar seu lugar.'),

		('TinkerBell: O Segredo das Fadas', 23.99, 9, 8, 'Tinker Bell, uma fada do verão, aventura-se no proibido Bosque do Inverno, onde conhece Periwinkle. Juntas, elas descobrem um segredo que pode mudar o Refúgio das Fadas para sempre.'),

		('Sorria', 21.59, 4, 13, 'Após testemunhar o suicídio de uma paciente, a Dra. Rose Cotter começa a vivenciar eventos aterrorizantes e inexplicáveis, levando-a a confrontar seu passado para sobreviver.'),

		('Tá Dando Onda', 13.90, 3, 9, 'Cadu Maverick, um jovem pinguim surfista, deixa sua cidade natal para competir no Big Z Memorial Surf Off, aprendendo lições valiosas sobre o verdadeiro significado da vitória.'),

		('Moana', 17.99, 9, 10, 'Moana, filha do chefe de uma tribo na Oceania, embarca em uma jornada pelo oceano para restaurar o coração da deusa Te Fiti e salvar seu povo das adversidades.'),

		('Um Porto Seguro', 23.00, 5, 6, 'Katie, uma mulher com um passado misterioso, muda-se para uma pequena cidade e encontra um novo começo ao se apaixonar por Alex, um viúvo com dois filhos.'),

		('O Estranho Mundo de Jack', 21.59, 9, 12, 'Jack Skellington, o rei da Cidade do Halloween, descobre a Cidade do Natal e tenta trazer o espírito natalino para seu mundo, com consequências inesperadas.'),

		('Coraline', 31.30, 9, 4, 'Coraline descobre uma porta secreta em sua nova casa que a leva a um mundo alternativo, onde tudo parece melhor, mas esconde perigos sombrios.'),

		('Barbie Butterfly', 27.99, 9, 10, 'Barbie interpreta Butterfly, uma fada borboleta que embarca em uma aventura para salvar seu reino e descobrir o poder da amizade.'),

		('Frozen', 27.99, 9, 12, 'A princesa Anna parte em uma jornada para encontrar sua irmã Elsa, cujos poderes congelantes prenderam o reino de Arendelle em um inverno eterno.'),

		('A Casa Monstro', 29.99, 3, 4, 'Três crianças descobrem que uma casa vizinha é, na verdade, um monstro vivo, e precisam encontrar uma maneira de destruí-la antes que ela faça mais vítimas.'),

		('A Era do Gelo', 24.99, 3, 9, 'Durante a era glacial, um grupo improvável de animais se une para devolver um bebê humano perdido à sua tribo.'),

		('Deu a Louca na Chapeuzinho', 11.99, 3, 9, 'Uma investigação policial reúne diferentes versões do clássico conto da Chapeuzinho Vermelho, revelando segredos e reviravoltas inesperadas.'),

		('Barbie Fada', 9.99, 9, 2, 'Barbie se transforma em uma fada mágica e embarca em uma aventura para salvar o mundo das fadas de uma ameaça iminente.'),

		('A Noiva Cadáver', 23.99, 9, 8, 'Victor acidentalmente se casa com uma noiva cadáver e é levado para o mundo dos mortos, onde aprende lições sobre amor e lealdade.'),

		('Gente Grande', 21.99, 3, 2, 'Cinco amigos de infância se reúnem com suas famílias para um fim de semana repleto de diversão, desafios e redescobertas.'),

		('Todos Menos Você', 21.99, 3, 6, 'Dois ex-namorados fingem estar juntos durante um casamento para evitar constrangimentos, reacendendo sentimentos antigos.'),

		('Os Vingadores', 25.99, 1, 10, 'Super-heróis como Homem de Ferro, Capitão América e Thor se unem para formar os Vingadores e salvar o mundo de uma ameaça global.'),

		('Ilha do Medo', 5.99, 5, 13, 'O detetive Teddy Daniels investiga o desaparecimento de uma paciente em um hospital psiquiátrico isolado, enfrentando revelações perturbadoras.'),

		('Homem-Aranha no Aranhaverso', 34.10, 1, 7, 'Miles Morales se torna o Homem-Aranha e encontra versões alternativas de si mesmo de diferentes dimensões para salvar o multiverso.'),

		('Invocação do Mal', 24.99, 4, 13, 'Os investigadores paranormais Ed e Lorraine Warren ajudam uma família aterrorizada por uma presença demoníaca em sua fazenda.'),

		('A Substância', 23.00, 4, 7, 'Uma mulher descobre uma substância misteriosa que promete juventude eterna, mas com efeitos colaterais assustadores.'),

		('Acompanhante Perfeita', 17.99, 4, 5, 'Uma jovem contrata uma acompanhante para fingir ser sua namorada durante um evento familiar, levando a situações inesperadas.'),

		('Batman vs Superman', 25.99, 1, 7, 'Batman vê Superman como uma ameaça à humanidade e decide enfrentá-lo, enquanto uma nova ameaça coloca o mundo em perigo.'),

		('Liga da Justiça', 23.99, 1, 10, 'Batman e Mulher-Maravilha recrutam uma equipe de meta-humanos para enfrentar uma ameaça apocalíptica e salvar o planeta.'),

		('Wicked', 25.99, 12, 8, 'A história não contada das bruxas de Oz, explorando a amizade e rivalidade entre Elphaba, a Bruxa Má do Oeste, e Glinda, a Bruxa Boa.'),

		('É Assim que Acaba', 21.99, 6, 2, 'Lily Bloom enfrenta desafios em um relacionamento abusivo e precisa tomar decisões difíceis para encontrar a felicidade.');

		-- Inserindo os links das imagens
		INSERT INTO tb_fotos (id_filme, img_1, img_2, img_banner) VALUES
		(1, 'https://br.web.img2.acsta.net/medias/nmedia/18/91/54/04/20150812.jpg', 'https://br.web.img2.acsta.net/medias/nmedia/18/91/54/04/20150812.jpg', 'https://br.web.img2.acsta.net/medias/nmedia/18/91/54/04/20150812.jpg'),
		(2, 'https://a-static.mlcdn.com.br/1500x1500/dvd-barbie-escola-de-princesas-universal-pictures-2017/nocnoceua/aub00511gsls/6e159f830c8a0674d03791e1ff755e47.jpeg', 'https://a-static.mlcdn.com.br/1500x1500/dvd-barbie-escola-de-princesas-universal-pictures-2017/nocnoceua/aub00511gsls/6e159f830c8a0674d03791e1ff755e47.jpeg', 'https://a-static.mlcdn.com.br/1500x1500/dvd-barbie-escola-de-princesas-universal-pictures-2017/nocnoceua/aub00511gsls/6e159f830c8a0674d03791e1ff755e47.jpeg'),
		(3, 'https://br.web.img3.acsta.net/medias/nmedia/18/92/72/77/20214259.jpg', 'https://br.web.img3.acsta.net/medias/nmedia/18/92/72/77/20214259.jpg', 'https://br.web.img3.acsta.net/medias/nmedia/18/92/72/77/20214259.jpg'),
		(4, 'https://m.media-amazon.com/images/S/pv-target-images/c344ff9ae2a6e50c63f7e329e4fb689a79d67a456662bf5074b194532542b288.jpg', 'https://m.media-amazon.com/images/S/pv-target-images/c344ff9ae2a6e50c63f7e329e4fb689a79d67a456662bf5074b194532542b288.jpg', 'https://m.media-amazon.com/images/S/pv-target-images/c344ff9ae2a6e50c63f7e329e4fb689a79d67a456662bf5074b194532542b288.jpg'),
		(5, 'https://m.media-amazon.com/images/I/71w45HNSCwL._AC_UF894,1000_QL80_.jpg', 'https://m.media-amazon.com/images/I/71w45HNSCwL._AC_UF894,1000_QL80_.jpg', 'https://m.media-amazon.com/images/I/71w45HNSCwL._AC_UF894,1000_QL80_.jpg'),
		(6, 'https://upload.wikimedia.org/wikipedia/pt/4/46/Moana_movie_poster_p_2016.jpg', 'https://upload.wikimedia.org/wikipedia/pt/4/46/Moana_movie_poster_p_2016.jpg', 'https://upload.wikimedia.org/wikipedia/pt/4/46/Moana_movie_poster_p_2016.jpg'),
		(7, 'https://br.web.img2.acsta.net/medias/nmedia/18/94/25/09/20455744.jpg', 'https://br.web.img2.acsta.net/medias/nmedia/18/94/25/09/20455744.jpg', 'https://br.web.img2.acsta.net/medias/nmedia/18/94/25/09/20455744.jpg'),
		(8, 'https://m.media-amazon.com/images/S/pv-target-images/4e67efbe61a1cd52df285b95332d349a919888bab95c880b550bb22934afaaa7.jpg', 'https://m.media-amazon.com/images/S/pv-target-images/4e67efbe61a1cd52df285b95332d349a919888bab95c880b550bb22934afaaa7.jpg', 'https://m.media-amazon.com/images/S/pv-target-images/4e67efbe61a1cd52df285b95332d349a919888bab95c880b550bb22934afaaa7.jpg'),
		(9, 'https://imusic.b-cdn.net/images/item/original/279/5050582702279.jpg?coraline-2009-coraline-dvd&class=scaled&v=1256830051', 'https://imusic.b-cdn.net/images/item/original/279/5050582702279.jpg?coraline-2009-coraline-dvd&class=scaled&v=1256830051', 'https://imusic.b-cdn.net/images/item/original/279/5050582702279.jpg?coraline-2009-coraline-dvd&class=scaled&v=1256830051'),
		(10, 'https://m.media-amazon.com/images/I/91Rh56HCoNL._AC_UF1000,1000_QL80_.jpg', 'https://m.media-amazon.com/images/I/91Rh56HCoNL._AC_UF1000,1000_QL80_.jpg', 'https://m.media-amazon.com/images/I/91Rh56HCoNL._AC_UF1000,1000_QL80_.jpg'),
		(11, 'https://upload.wikimedia.org/wikipedia/pt/e/e5/Frozen_2013.png', 'https://upload.wikimedia.org/wikipedia/pt/e/e5/Frozen_2013.png', 'https://upload.wikimedia.org/wikipedia/pt/e/e5/Frozen_2013.png'),
		(12, 'https://br.web.img3.acsta.net/medias/nmedia/18/92/91/56/20224905.jpg', 'https://br.web.img3.acsta.net/medias/nmedia/18/92/91/56/20224905.jpg', 'https://br.web.img3.acsta.net/medias/nmedia/18/92/91/56/20224905.jpg'),
		(13, 'https://br.web.img3.acsta.net/medias/nmedia/18/90/29/80/20109874.jpg', 'https://br.web.img3.acsta.net/medias/nmedia/18/90/29/80/20109874.jpg', 'https://br.web.img3.acsta.net/medias/nmedia/18/90/29/80/20109874.jpg'),
		(14, 'https://m.media-amazon.com/images/M/MV5BNDlhMmIzMzktZTExZi00MzFiLWJkNDUtYzc2ZmViMGI5M2E5XkEyXkFqcGc@._V1_.jpg', 'https://m.media-amazon.com/images/M/MV5BNDlhMmIzMzktZTExZi00MzFiLWJkNDUtYzc2ZmViMGI5M2E5XkEyXkFqcGc@._V1_.jpg', 'https://m.media-amazon.com/images/M/MV5BNDlhMmIzMzktZTExZi00MzFiLWJkNDUtYzc2ZmViMGI5M2E5XkEyXkFqcGc@._V1_.jpg'),
		(15, 'https://upload.wikimedia.org/wikipedia/pt/c/c9/Barbie_Fairy_Secret.png', 'https://upload.wikimedia.org/wikipedia/pt/c/c9/Barbie_Fairy_Secret.png', 'https://upload.wikimedia.org/wikipedia/pt/c/c9/Barbie_Fairy_Secret.png'),
		(16, 'https://br.web.img2.acsta.net/medias/nmedia/18/91/33/59/20140728.jpg', 'https://br.web.img2.acsta.net/medias/nmedia/18/91/33/59/20140728.jpg', 'https://br.web.img2.acsta.net/medias/nmedia/18/91/33/59/20140728.jpg'),
		(17, 'https://br.web.img3.acsta.net/pictures/210/299/21029996_20130821205722213.jpg', 'https://br.web.img3.acsta.net/pictures/210/299/21029996_20130821205722213.jpg', 'https://br.web.img3.acsta.net/pictures/210/299/21029996_20130821205722213.jpg'),
		(18, 'https://encrypted-tbn1.gstatic.com/images?q=tbn:ANd9GcSgq4HgefMkbAAyUwlTjuY9yBSubI08uAW5iIqIH5cY3MdfGORN', 'https://encrypted-tbn1.gstatic.com/images?q=tbn:ANd9GcSgq4HgefMkbAAyUwlTjuY9yBSubI08uAW5iIqIH5cY3MdfGORN', 'https://encrypted-tbn1.gstatic.com/images?q=tbn:ANd9GcSgq4HgefMkbAAyUwlTjuY9yBSubI08uAW5iIqIH5cY3MdfGORN'),
		(19, 'https://br.web.img2.acsta.net/medias/nmedia/18/89/43/82/20052140.jpg', 'https://br.web.img2.acsta.net/medias/nmedia/18/89/43/82/20052140.jpg', 'https://br.web.img2.acsta.net/medias/nmedia/18/89/43/82/20052140.jpg'),
		(20, 'https://www.cinebelasartes.com.br/wp-content/uploads/2016/03/ILHA-DO-MEDO.jpg', 'https://www.cinebelasartes.com.br/wp-content/uploads/2016/03/ILHA-DO-MEDO.jpg', 'https://www.cinebelasartes.com.br/wp-content/uploads/2016/03/ILHA-DO-MEDO.jpg'),
		(21, 'https://www.sonypictures.com.br/sites/brazil/files/2023-06/1400x2100.jpg', 'https://www.sonypictures.com.br/sites/brazil/files/2023-06/1400x2100.jpg', 'https://www.sonypictures.com.br/sites/brazil/files/2023-06/1400x2100.jpg'),
		(22, 'https://m.media-amazon.com/images/I/91UQCBxB+cL._AC_UF894,1000_QL80_.jpg', 'https://m.media-amazon.com/images/I/91UQCBxB+cL._AC_UF894,1000_QL80_.jpg', 'https://m.media-amazon.com/images/I/91UQCBxB+cL._AC_UF894,1000_QL80_.jpg'),
		(23, 'https://m.media-amazon.com/images/S/pv-target-images/d40e2853996d20ff038e1a9bb5cad0c2bd75360b123a8daae467cd34c60c4e36.jpg', 'https://m.media-amazon.com/images/S/pv-target-images/d40e2853996d20ff038e1a9bb5cad0c2bd75360b123a8daae467cd34c60c4e36.jpg', 'https://m.media-amazon.com/images/S/pv-target-images/d40e2853996d20ff038e1a9bb5cad0c2bd75360b123a8daae467cd34c60c4e36.jpg'),
		(24, 'https://m.media-amazon.com/images/S/pv-target-images/7d50a779768ec84cd1479efd04f59c1c3c73c8891576cc3d6ba4e124b19fc8f4.jpg', 'https://m.media-amazon.com/images/S/pv-target-images/7d50a779768ec84cd1479efd04f59c1c3c73c8891576cc3d6ba4e124b19fc8f4.jpg', 'https://m.media-amazon.com/images/S/pv-target-images/7d50a779768ec84cd1479efd04f59c1c3c73c8891576cc3d6ba4e124b19fc8f4.jpg'),
		(25, 'https://wp.ufpel.edu.br/empauta/files/2016/04/BatmanVsSuperman2.jpg', 'https://wp.ufpel.edu.br/empauta/files/2016/04/BatmanVsSuperman2.jpg', 'https://wp.ufpel.edu.br/empauta/files/2016/04/BatmanVsSuperman2.jpg'),
		(26, 'https://br.web.img2.acsta.net/pictures/17/10/23/19/55/0260439.jpg', 'https://br.web.img2.acsta.net/pictures/17/10/23/19/55/0260439.jpg', 'https://br.web.img2.acsta.net/pictures/17/10/23/19/55/0260439.jpg'),
		(27, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS5QJrkH4M_LZKMXNTcfb5YgjTOpMkJLsYSHA&s','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS5QJrkH4M_LZKMXNTcfb5YgjTOpMkJLsYSHA&s','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS5QJrkH4M_LZKMXNTcfb5YgjTOpMkJLsYSHA&s'),
		(28, 'https://br.web.img2.acsta.net/img/61/b3/61b35aa40057cba4f7df23c689d6979e.PNG', 'https://br.web.img2.acsta.net/img/61/b3/61b35aa40057cba4f7df23c689d6979e.PNG', 'https://br.web.img2.acsta.net/img/61/b3/61b35aa40057cba4f7df23c689d6979e.PNG');

		INSERT INTO tb_usuarios(nome_usuario, usuario, senha)
		VALUES
		("gustavo rodrigues","gustav0rdg","ef797c8118f02dfb649607dd5d3f8c7623048c9c063d532cc95c5ed7a898a64f"),
		("ivo neto","icneto","ef797c8118f02dfb649607dd5d3f8c7623048c9c063d532cc95c5ed7a898a64f"),
		('carla dias', 'carlad', 'ef797c8118f02dfb649607dd5d3f8c7623048c9c063d532cc95c5ed7a898a64f'),
		('lucas silva', 'lucass', 'ef797c8118f02dfb649607dd5d3f8c7623048c9c063d532cc95c5ed7a898a64f'),
		('mariana almeida', 'marial', 'ef797c8118f02dfb649607dd5d3f8c7623048c9c063d532cc95c5ed7a898a64f'),
		("alicia pavao","alicia123","ef797c8118f02dfb649607dd5d3f8c7623048c9c063d532cc95c5ed7a898a64f"),
		('beatriz souza', 'beatrizs', 'ef797c8118f02dfb649607dd5d3f8c7623048c9c063d532cc95c5ed7a898a64f'),
		('daniel alves', 'daniela', 'ef797c8118f02dfb649607dd5d3f8c7623048c9c063d532cc95c5ed7a898a64f'),
		('fernanda lima', 'fernandal', 'ef797c8118f02dfb649607dd5d3f8c7623048c9c063d532cc95c5ed7a898a64f');


		INSERT INTO tb_comentarios (id_filme, id_usuario, avaliacao, comentario)
		VALUES
		(1, 1, 5, 'Excelente do início ao fim!'),
		(2, 2, 5, 'Roteiro envolvente e atuações incríveis.'),
		(3, 3, 5, 'Visualmente deslumbrante!'),
		(4, 1, 5, 'Superou todas as expectativas.'),
		(5, 2, 5, 'Final emocionante e bem construído.'),
		(6, 3, 5, 'Trilha sonora perfeita para a história.'),
		(7, 1, 5, 'Personagens bem desenvolvidos.'),
		(8, 2, 5, 'Uma experiência imperdível.'),
		(9, 3, 5, 'Direção impecável e criativa.'),
		(10, 1, 5, 'Simplesmente sensacional!'),
		(11, 2, 5, 'Bom, mas poderia ser mais profundo.'),
		(12, 3, 5, 'Teve ótimos momentos, mas também foi arrastado.'),
		(13, 1, 5, 'Elenco forte, mas roteiro previsível.'),
		(14, 2, 5, 'Vale assistir, mas não é memorável.'),
		(15, 3, 5, 'Algumas partes empolgam, outras nem tanto.'),
		(16, 1, 5, 'Final inesperado, porém confuso.'),
		(17, 2, 5, 'Visual incrível, história fraca.'),
		(18, 3, 5, 'Interessante, mas faltou emoção.'),
		(19, 1, 5, 'Promissor, mas mal aproveitado.'),
		(20, 2, 5, 'Ok para passar o tempo.'),
		(21, 3, 5, 'Muito abaixo do esperado.'),
		(22, 1, 5, 'História sem graça e mal contada.'),
		(23, 2, 5, 'Ritmo lento e cansativo.'),
		(24, 3, 5, 'Diálogos fracos e atuações forçadas.'),
		(25, 1, 5, 'Personagens sem profundidade.'),
		(26, 2, 5, 'Final decepcionante.'),
		(27, 3, 5, 'Pouco original e repetitivo.'),
		(1, 1, 5, 'Não prende a atenção.'),
		(2, 2, 5, 'Trilha sonora genérica.'),
		(3, 3, 5, 'Faltou emoção do começo ao fim.'),
		(1, 4, 2, 'Esperava mais do enredo, achei previsível.'),
		(2, 5, 3, 'Animação bonita, mas a história não me cativou.'),
		(3, 6, 2, 'Visualmente interessante, porém faltou profundidade.'),
		(4, 4, 1, 'Não consegui me conectar com os personagens.'),
		(5, 5, 2, 'Algumas piadas foram forçadas, não achei tão engraçado.'),
		(6, 6, 3, 'Trilha sonora boa, mas a narrativa é arrastada.'),
		(7, 4, 2, 'Romance clichê, sem novidades.'),
		(8, 5, 3, 'Estilo único, mas não é para todos os gostos.'),
		(9, 6, 2, 'Achei o clima muito sombrio para uma animação.'),
		(10, 4, 1, 'Não gostei da abordagem da história.'),
		(11, 5, 2, 'Músicas boas, mas o roteiro é fraco.'),
		(12, 6, 3, 'Algumas cenas assustadoras, mas sem coesão.'),
		(13, 4, 2, 'Personagens divertidos, mas história previsível.'),
		(14, 5, 3, 'Algumas partes engraçadas, outras nem tanto.'),
		(15, 6, 2, 'Faltou emoção na narrativa.'),
		(16, 4, 1, 'Não consegui entender a proposta do filme.'),
		(17, 5, 2, 'Humor exagerado, não me agradou.'),
		(18, 6, 3, 'Romance sem química entre os protagonistas.'),
		(19, 4, 2, 'Ação genérica, nada memorável.'),
		(20, 5, 3, 'Suspense interessante, mas previsível.'),
		(21, 6, 2, 'Animação inovadora, mas confusa.'),
		(22, 4, 1, 'Terror sem sustos, decepcionante.'),
		(23, 5, 2, 'História confusa e pouco envolvente.'),
		(24, 6, 3, 'Drama com atuações medianas.'),
		(25, 4, 2, 'Conflito épico, mas mal executado.'),
		(26, 5, 3, 'Reunião de heróis sem profundidade.'),
		(27, 6, 2, 'Musical com performances fracas.'),
		(28, 4, 1, 'História sem graça e mal contada.'),
		(1, 7, 5, 'Uma animação divertida para todas as idades.'),
		(1, 8, 4, 'Humor inteligente e personagens cativantes.'),
		(2, 9, 3, 'História encantadora, mas previsível.'),
		(2, 7, 4, 'Ótima mensagem para crianças.'),
		(3, 8, 4, 'Visualmente bonito e emocionante.'),
		(3, 9, 3, 'Boa animação, mas enredo simples.'),
		(4, 7, 2, 'Assustador, mas com clichês do gênero.'),
		(4, 8, 3, 'Boa atuação, final poderia ser melhor.'),
		(5, 9, 4, 'Animação divertida e original.'),
		(5, 7, 3, 'Boa para passar o tempo.'),
		(6, 8, 5, 'Trilha sonora incrível e protagonista inspiradora.'),
		(6, 9, 4, 'Visual deslumbrante e história envolvente.'),
		(7, 7, 3, 'Romance agradável, mas previsível.'),
		(7, 8, 2, 'Enredo clichê, atuações medianas.'),
		(8, 9, 5, 'Animação única e trilha sonora marcante.'),
		(8, 7, 4, 'Visual criativo, história interessante.'),
		(9, 8, 5, 'Atmosfera sombria e envolvente.'),
		(9, 9, 4, 'Animação impressionante e enredo cativante.'),
		(10, 7, 3, 'Colorido e divertido para crianças.'),
		(10, 8, 2, 'História simples, mas encantadora.'),
		(11, 9, 5, 'Músicas inesquecíveis e personagens fortes.'),
		(11, 7, 4, 'Animação linda e história emocionante.'),
		(12, 8, 3, 'Assustador na medida certa para crianças.'),
		(12, 9, 2, 'Enredo poderia ser mais elaborado.'),
		(13, 7, 4, 'Personagens carismáticos e humor divertido.'),
		(13, 8, 3, 'Boa animação, mas história simples.'),
		(14, 9, 3, 'Releitura interessante do conto clássico.'),
		(14, 7, 2, 'Algumas piadas funcionam, outras não.'),
		(15, 8, 3, 'Encantador para o público infantil.'),
		(15, 9, 2, 'História básica, mas visual bonito.'),
		(16, 7, 5, 'Animação sombria e emocionante.'),
		(16, 8, 4, 'Estilo único e história envolvente.'),
		(17, 9, 3, 'Comédia leve para toda a família.'),
		(17, 7, 2, 'Algumas piadas forçadas, mas divertido.'),
		(18, 8, 3, 'Romance moderno com química entre os protagonistas.'),
		(18, 9, 2, 'História previsível, mas atuações boas.'),
		(19, 7, 5, 'Ação intensa e personagens icônicos.'),
		(19, 8, 4, 'Enredo envolvente e efeitos especiais incríveis.'),
		(20, 9, 5, 'Suspense psicológico de tirar o fôlego.'),
		(20, 7, 4, 'Final surpreendente e atuações excelentes.'),
		(21, 8, 5, 'Animação inovadora e história emocionante.'),
		(21, 9, 4, 'Visual impressionante e enredo cativante.'),
		(22, 7, 4, 'Terror eficaz com sustos bem construídos.'),
		(22, 8, 3, 'Atmosfera tensa e enredo interessante.'),
		(23, 9, 2, 'Ideia interessante, mas execução fraca.'),
		(23, 7, 3, 'Conceito bom, mas faltou desenvolvimento.'),
		(24, 8, 3, 'Comédia romântica leve e divertida.'),
		(24, 9, 2, 'História clichê, mas atuações agradáveis.'),
		(25, 7, 3, 'Ação intensa, mas enredo confuso.'),
		(25, 8, 2, 'Personagens icônicos, mas roteiro fraco.'),
		(26, 9, 3, 'Reunião de heróis empolgante, mas com falhas.'),
		(26, 7, 2, 'Efeitos especiais bons, mas história fraca.'),
		(27, 8, 4, 'Musical encantador com performances incríveis.'),
		(27, 9, 3, 'História envolvente e trilha sonora marcante.'),
		(28, 7, 4, 'Drama emocional com atuações fortes.'),
		(28, 8, 3, 'Enredo impactante, mas ritmo lento.');