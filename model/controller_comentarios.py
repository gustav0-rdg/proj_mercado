from data.conexao import Connection

class Comentarios:

    def exibir(id_filme):
      
        conexao = Connection.create()
        cursor = conexao.cursor()

        try:
          sql_select = """
                    SELECT 
                    c.id_comentario,
                    u.nome_usuario,
                    c.id_filme,
                    c.id_usuario,
                    f.nome_filme,
                    c.avaliacao,
                    c.comentario,
                    c.data
                FROM tb_comentarios c
                INNER JOIN tb_usuarios u ON c.id_usuario = u.id_usuario
                INNER JOIN tb_filmes f ON c.id_filme = f.id_filme
                WHERE c.id_filme = %s;
            """
          
          cursor.execute(sql_select, (id_filme,))
          
          linhas = cursor.fetchall() 
          
          colunas = [desc[0] for desc in cursor.description]  # pega nomes das colunas
          comentarios = [dict(zip(colunas, linha)) for linha in linhas]  # monta lista de dicts
            
          return comentarios
        
        except Exception as e:
            print(e)
            return []
          
        finally:
            cursor.close()
            conexao.close()
    
    def add(id_filme, id_usuario, avaliacao, comentario):

        conexao = Connection.create()
        cursor = conexao.cursor()

        try:
            print(id_filme)
            print(id_usuario)
            print(avaliacao)
            print(comentario)
            sql = "INSERT INTO tb_comentarios(id_filme, id_usuario, avaliacao, comentario) VAlUES(%s, %s, %s, %s)"
            cursor.execute(sql, (id_filme, id_usuario, avaliacao, comentario))
            conexao.commit()
            return True

        except Exception as e:
            print(e)
            return
        
        finally:
            cursor.close()
            conexao.close()

    def remover_comentario(id_comentario):
        conexao = Connection.create()
        cursor = conexao.cursor(dictionary=True)

        try:
            sql_insert = "DELETE FROM tb_comentarios WHERE id_comentario = %s"
            cursor.execute(sql_insert, (id_comentario,))
            conexao.commit()

            return True
            
        except Exception as e:
            print(e)
            return False

        finally:
            cursor.close()
            conexao.close()