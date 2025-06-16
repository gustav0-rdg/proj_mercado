from data.conexao import Connection

class SuperUser:
    def add_filme(nome, categoria, subcategoria, preco, sinopse, img1, img2):
        conexao = Connection.create()
        cursor = conexao.cursor()
        try:
            # Inserir o filme
            cursor.execute("""
                INSERT INTO tb_filmes (nome_filme, id_categoria, id_subgenero, preco, sinopse)
                VALUES (%s, %s, %s, %s, %s)
            """, (nome, categoria, subcategoria, preco, sinopse))

            # Pegar o ID do filme inserido
            id_filme = cursor.lastrowid

            # Inserir fotos relacionadas
            cursor.execute("""
                INSERT INTO tb_fotos (id_filme, img_1, img_2, img_banner)
                VALUES (%s, %s, %s, %s)
            """, (id_filme, img1, img2, 'img_teste'))

            conexao.commit()
            return id_filme  # se quiser usar depois

        except Exception as e:
            print("Erro ao inserir filme:", e)
        finally:
            conexao.close()
    
    def update(id_filme, nome, categoria, subcategoria, preco, sinopse, img_1, img_2, img_banner):
        conexao = Connection.create()
        cursor = conexao.cursor()
        try:
            cursor.execute("""UPDATE tb_filmes 
                            SET nome_filme = %s, 
                            sinopse = %s,
                            preco = %s,
                            id_categoria = %s,
                            id_subgenero = %s
                            WHERE id_filme = %s;""",(nome, sinopse, preco, categoria, subcategoria, id_filme))
            
            cursor.execute("""UPDATE tb_fotos
                            SET img_1 = %s, 
                            img_2 = %s,
                            img_banner = %s
                            WHERE id_filme = %s; 
                            """, (img_1, img_2, img_banner, id_filme))
            conexao.commit()

        except Exception as e:
            print(e)
        finally:
            conexao.close()
    