from data.conexao import Connection

class SuperUser:

    def add_filme(nome, categoria, subcategoria, preco, sinopse, img1, img2):

        conexao = Connection.create()
        cursor = conexao.cursor()
        
        try:
            cursor.execute("""
                INSERT INTO tb_filmes (nome_filme, id_categoria, id_subgenero, preco, sinopse)
                VALUES (%s, %s, %s, %s, %s)
            """, (nome, categoria, subcategoria, preco, sinopse))

            id_filme = cursor.lastrowid

            cursor.execute("""
                INSERT INTO tb_fotos (id_filme, img_1, img_2, img_banner)
                VALUES (%s, %s, %s, %s)
            """, (id_filme, img1, img2, 'img_teste'))

            conexao.commit()
            return id_filme

        except Exception as e:
            print("Erro ao inserir filme:", e)
            return False
        finally:
            conexao.close()
    
    def update(id_filme, nome, categoria, subcategoria, preco, sinopse, img_1, img_2):

        conexao = Connection.create()
        cursor = conexao.cursor()
        try:

            cursor.execute("""
                UPDATE tb_filmes 
                SET nome_filme = %s, 
                    sinopse = %s,
                    preco = %s,
                    id_categoria = %s,
                    id_subgenero = %s
                WHERE id_filme = %s
            """, (nome, sinopse, preco, categoria, subcategoria, id_filme))
            

            cursor.execute("""
                UPDATE tb_fotos
                SET img_1 = %s, 
                    img_2 = %s
                WHERE id_filme = %s
            """, (img_1, img_2, id_filme))
            
            conexao.commit()
            return True

        except Exception as e:
            print("Erro ao atualizar filme:", e)
            return False
        finally:
            cursor.close()
            conexao.close()

    def delete(id_filme):
        conexao = Connection.create()
        cursor = conexao.cursor()
        try:
            cursor.execute("DELETE FROM tb_comentarios WHERE id_filme = %s", (id_filme,))

            cursor.execute("DELETE FROM tb_fotos WHERE id_filme = %s", (id_filme,))
            
            cursor.execute("DELETE FROM tb_filmes WHERE id_filme = %s", (id_filme,))
            
            conexao.commit()
            return True

        except Exception as e:
            print("Erro ao deletar filme:", e)
            return False
        finally:
            cursor.close()
            conexao.close()