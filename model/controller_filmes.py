from data.conexao import Connection

class Filme():

    def exibirTodos():

        conexao = Connection.create()
        cursor = conexao.cursor(dictionary=True)

        try:

            comando_sql = """SELECT
	            f.id_filme,
                f.nome_filme,
                c.categoria,
                img.img_1,
                subc.categoria as sub_categoria,
                f.preco
            FROM tb_filmes f
            INNER JOIN tb_categorias c ON f.id_categoria = c.id_categoria
            INNER JOIN tb_categorias subc ON f.id_subgenero = subc.id_categoria
            INNER JOIN tb_fotos img ON f.id_filme = img.id_filme; """

            cursor.execute(comando_sql)
            lista_filmes = cursor.fetchall()
            return lista_filmes
        
        except Exception as e:

            print(e)
            return []

        finally:

            cursor.close()
            conexao.close()

    def exibir(id):
        
        conexao = Connection.create()
        cursor = conexao.cursor(dictionary=True)

        try:

            filme = ''

            comando_sql = """SELECT
                    f.preco,
                    f.id_filme,
                    f.nome_filme,
                    f.sinopse,
                    c.categoria,
                    img.img_1,
                    subc.categoria AS sub_categoria,
                    (
                        SELECT ROUND(AVG(avaliacao), 1)
                        FROM tb_comentarios
                        WHERE id_filme = f.id_filme
                    ) AS media_avaliacao
                    FROM tb_filmes f
                    INNER JOIN tb_categorias c ON f.id_categoria = c.id_categoria
                    INNER JOIN tb_categorias subc ON f.id_subgenero = subc.id_categoria
                    INNER JOIN tb_fotos img ON f.id_filme = img.id_filme
                    WHERE f.id_filme = %s; 
            """
            cursor.execute(comando_sql, (id,))
            filme = cursor.fetchone()
        except Exception as e:

            print(e)
            return ''
        
        finally:

            cursor.close()
            conexao.close()
            return filme
        
    def categorias():

        conexao = Connection.create()
        cursor = conexao.cursor(dictionary=True)

        try:
            comando_sql = """SELECT
                    c.id_categoria,
                    c.categoria
                    FROM tb_categorias c
            """
            cursor.execute(comando_sql)
            categorias = cursor.fetchall()

        except:
            return []
        
        finally:
            cursor.close()
            conexao.close()
            return categorias

    def exibirCategoria(categoria):

        conexao = Connection.create()
        cursor = conexao.cursor(dictionary=True)

        try:
            comando_sql = """SELECT
                f.id_filme,
                f.nome_filme,
                c.categoria,
                img.img_1,
                subc.categoria as sub_categoria,
                f.preco
            FROM tb_filmes f
            INNER JOIN tb_categorias c ON f.id_categoria = c.id_categoria
            INNER JOIN tb_categorias subc ON f.id_subgenero = subc.id_categoria
            INNER JOIN tb_fotos img ON f.id_filme = img.id_filme
            WHERE c.id_categoria = %s; """
            cursor.execute(comando_sql, (categoria,))
            filmes = cursor.fetchall()

        except:
            return []
        
        finally:
            conexao.close()
            cursor.close()
            return filmes