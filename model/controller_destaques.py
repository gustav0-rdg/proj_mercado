from data.conexao import Connection

class Destaques:
    staticmethod
    def exibir_destaque():
        conexao = Connection.create()
        cursor = conexao.cursor(dictionary=True)

        try:
            sql_select = """
                    SELECT
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
                    ORDER BY media_avaliacao DESC
                    LIMIT 1;
            """
            cursor.execute(sql_select, )
            linhas = cursor.fetchone() 
            return linhas

        except Exception as e:
            print(e)
            return []
          
        finally:
            cursor.close()
            conexao.close()

    def exibir_melhores():
        conexao = Connection.create()
        cursor = conexao.cursor(dictionary=True)

        try:
            sql_select = """
                    SELECT
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
                    ORDER BY media_avaliacao DESC
                    LIMIT 5 OFFSET 1;
            """
            cursor.execute(sql_select, )
            linhas = cursor.fetchall() 
        except Exception as e:
            print(e)
            return []
          
        finally:
            cursor.close()
            conexao.close()
            return linhas