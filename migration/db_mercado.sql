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
INSERT INTO tb_filmes (nome_filme, preco, id_categoria, id_subgenero)
VALUES 
('Sherek', 20.00, 3, 8),
('Barbie escola de princesas', 17.99, 2, 9),
('TinkerBell o segredo das fadas', 23.99, 9, 8),
('Sorria', 21.59, 4, 13),
('Tá dando onda', 13.90, 3, 9),
('Moana', 17.99, 9, 10),
('Um porto seguro', 23.00, 5, 6),
('O estranho mundo de jack', 21.59, 9, 12),
('Coraline', 31.30, 9, 4),
('Barbie butterfly', 27.99, 9, 10),
('Frozen', 27.99, 9, 12),
('A casa monstro', 29.99, 3, 4),
('A era do gelo', 24.99, 3, 9),
('Deu a louca na chapéuzinho', 11.99, 3, 9),
('Barbie fada', 9.99, 9, 2),
('Noiva cadaver', 23.99, 9, 8),
('Gente grande', 21.99, 3, 2),
('Todos menos você', 21.99, 3, 6),
('Os vingadores', 25.99, 1, 10),
('Ilha do medo', 5.99, 5, 13),
('Homem-aranha no aranhaverso', 34.10, 1, 7),
('Invocação do mal', 24.99, 4, 13),
('A substância', 23.00, 4, 7),
('Acompanhante perfeita', 17.99, 4, 5),
('Batman vs Superman', 25.99, 1, 7),
('Liga da justiça', 23.99, 1, 10),
('Wicked', 25.99, 12, 8),
('É assim que acaba', 21.99, 6, 2);

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
(27, 'https://br.web.img2.acsta.net/img/61/b3/61b35aa40057cba4f7df23c689d6979e.PNG', 'https://br.web.img2.acsta.net/img/61/b3/61b35aa40057cba4f7df23c689d6979e.PNG', 'https://br.web.img2.acsta.net/img/61/b3/61b35aa40057cba4f7df23c689d6979e.PNG');
	
INSERT INTO tb_usuario(nome_usuario, usuario, senha)VALUES("alicia pavao","alicia123","ef797c8118f02dfb649607dd5d3f8c7623048c9c063d532cc95c5ed7a898a64f");
INSERT INTO tb_usuario(nome_usuario, usuario, senha)VALUES("gustavo rodrigues","gustav0rdg","ef797c8118f02dfb649607dd5d3f8c7623048c9c063d532cc95c5ed7a898a64f");
INSERT INTO tb_usuario(nome_usuario, usuario, senha)VALUES("ivo neto","icneto","ef797c8118f02dfb649607dd5d3f8c7623048c9c063d532cc95c5ed7a898a64f");

INSERT INTO tb_comentarios (id_filme, id_usuario, avaliacao, comentario)
VALUES
  -- Filme id=1, usuário id=1
  (1, 1, 5, 'Excelente do início ao fim!'),
  -- Filme id=2, usuário id=2
  (2, 2, 5, 'Roteiro envolvente e atuações incríveis.'),
  -- Filme id=3, usuário id=3
  (3, 3, 5, 'Visualmente deslumbrante!'),
  -- Filme id=4, usuário id=1
  (4, 1, 5, 'Superou todas as expectativas.'),
  -- Filme id=5, usuário id=2
  (5, 2, 5, 'Final emocionante e bem construído.'),
  -- Filme id=6, usuário id=3
  (6, 3, 5, 'Trilha sonora perfeita para a história.'),
  -- Filme id=7, usuário id=1
  (7, 1, 5, 'Personagens bem desenvolvidos.'),
  -- Filme id=8, usuário id=2
  (8, 2, 5, 'Uma experiência imperdível.'),
  -- Filme id=9, usuário id=3
  (9, 3, 5, 'Direção impecável e criativa.'),
  -- Filme id=10, usuário id=1
  (10, 1, 5, 'Simplesmente sensacional!'),
  -- Filme id=11, usuário id=2
  (11, 2, 5, 'Bom, mas poderia ser mais profundo.'),
  -- Filme id=12, usuário id=3
  (12, 3, 5, 'Teve ótimos momentos, mas também foi arrastado.'),
  -- Filme id=13, usuário id=1
  (13, 1, 5, 'Elenco forte, mas roteiro previsível.'),
  -- Filme id=14, usuário id=2
  (14, 2, 5, 'Vale assistir, mas não é memorável.'),
  -- Filme id=15, usuário id=3
  (15, 3, 5, 'Algumas partes empolgam, outras nem tanto.'),
  -- Filme id=16, usuário id=1
  (16, 1, 5, 'Final inesperado, porém confuso.'),
  -- Filme id=17, usuário id=2
  (17, 2, 5, 'Visual incrível, história fraca.'),
  -- Filme id=18, usuário id=3
  (18, 3, 5, 'Interessante, mas faltou emoção.'),
  -- Filme id=19, usuário id=1
  (19, 1, 5, 'Promissor, mas mal aproveitado.'),
  -- Filme id=20, usuário id=2
  (20, 2, 5, 'Ok para passar o tempo.'),
  -- Filme id=21, usuário id=3
  (21, 3, 5, 'Muito abaixo do esperado.'),
  -- Filme id=22, usuário id=1
  (22, 1, 5, 'História sem graça e mal contada.'),
  -- Filme id=23, usuário id=2
  (23, 2, 5, 'Ritmo lento e cansativo.'),
  -- Filme id=24, usuário id=3
  (24, 3, 5, 'Diálogos fracos e atuações forçadas.'),
  -- Filme id=25, usuário id=1
  (25, 1, 5, 'Personagens sem profundidade.'),
  -- Filme id=26, usuário id=2
  (26, 2, 5, 'Final decepcionante.'),
  -- Filme id=27, usuário id=3
  (27, 3, 5, 'Pouco original e repetitivo.'),
  -- Voltando ao início da lista de filmes:
  -- Filme id=1, usuário id=1
  (1, 1, 5, 'Não prende a atenção.'),
  -- Filme id=2, usuário id=2
  (2, 2, 5, 'Trilha sonora genérica.'),
  -- Filme id=3, usuário id=3
  (3, 3, 5, 'Faltou emoção do começo ao fim.');