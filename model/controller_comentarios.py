from data.conexao import Connection

class Comentarios:
    def exibir():
        conexao = Connection.create()
        cursor = conexao.cursor()
        try:
            sql_select="""SELECT 
                    u.nome_usuario,
                    c.id_filme,
                    c.id_usuario,
                    f.nome_filme,
                    c.avaliacao,
                    c.comentario,
                    c.data
                FROM tb_comentarios c
                INNER JOIN tb_usuarios u ON c.id_usuario = u.id_usuario
                INNER JOIN tb_filmes f ON f.id_filme = f.id_filme;
            """
            cursor.execute(sql_select)
            comentarios = cursor.fetchall()
        except Exception as e:
            print(e)
            return
        finally:
            cursor.close()
            conexao.close()
            return comentarios