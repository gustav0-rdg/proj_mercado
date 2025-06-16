from data.conexao import Connection

class SuperUser:
    def add_filme(nome, categoria, subcategoria, preco, sinopse):
        conexao = Connection.create()
        cursor = conexao.cursor()
        try:
            cursor.execute("""INSERT INTO tb_filmes(nome_filme, id_categoria, id_subgenero,preco, sinopse)
                           VALUES(%s,%s,%s,%s,%s)""",(nome, categoria, subcategoria, preco, sinopse))
            cursor.execute("""INSERT INTO tb_fotos(id_filme, img_1, img_2, img_banner)
                           VALUES(%s,%s,%s,%s)""", ())
            conexao.commit()
        except Exception as e:
            print(e)
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
    