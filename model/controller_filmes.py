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
	            f.id_filme,
                f.nome_filme,
                c.categoria,
                img.img_1,
                subc.categoria as sub_categoria,
                f.preco
            FROM tb_filmes f
            WHERE f.id_filme = %s
            INNER JOIN tb_categorias c ON f.id_categoria = c.id_categoria
            INNER JOIN tb_categorias subc ON f.id_subgenero = subc.id_categoria
            INNER JOIN tb_fotos img ON f.id_filme = img.id_filme; """
            filme = cursor.execute(comando_sql, (id,))

        except Exception as e:

            print(e)
            return ''
        
        finally:

            cursor.close()
            conexao.close()
            return filme