from data.conexao import Connection

class Carrinho:

    def add(id_filme, id_usuario):

        conexao = Connection.create()
        cursor = conexao.cursor(dictionary=True)

        try:

            cursor.execute("SELECT * from tb_carrinho where binary id_usuario = %s", (id_usuario, ))
            carrinho = cursor.fetchone()

            if carrinho is None:
                cursor.execute("INSERT INTO tb_carrinho(id_usuario, status_pedido, criado_em)VALUES(%s,%s, now());", (id_usuario, "PENDENTE"))
                conexao.commit()
                cursor.execute("SELECT * from tb_carrinho where binary id_usuario = %s", (id_usuario, ))
                carrinho = cursor.fetchone()

            id_carrinho = carrinho['id_carrinho']
            cursor.execute("select * from tb_carrinho_itens where binary id_carrinho = %s and binary id_filme = %s", (id_carrinho, id_filme))
            filme = cursor.fetchone()

            if filme:
                cursor.execute("""
                               update tb_carrinho_itens 
                               set quantidade = quantidade + 1 
                               where binary id_carrinho = %s and binary id_filme = %s""", (id_carrinho, id_filme))
                conexao.commit()
                return True
            
            cursor.execute("SELECT * FROM tb_filmes WHERE id_filme = %s", (id_filme,))
            dados_filme = cursor.fetchone()

            if not dados_filme:
                raise Exception("Filme não encontrado.")
            
            preco = dados_filme['preco']
                
    
            sql_insert = "INSERT INTO tb_carrinho_itens(id_carrinho, id_filme, quantidade, preco) VALUES (%s, %s, %s, %s)"
            cursor.execute(sql_insert, (id_carrinho, id_filme, 1, preco))
            conexao.commit()
            
        except Exception as e:
            print(e)
            return False
        
        finally:
            conexao.close()
    
    def remove(id_filme, id_usuario):

        conexao = Connection.create()
        cursor = conexao.cursor(dictionary=True)

        try:

            cursor.execute("SELECT * from tb_carrinho where binary id_usuario = %s", (id_usuario, ))
            carrinho = cursor.fetchone()
            id_carrinho = carrinho['id_carrinho']       
    
            sql_insert = "DELETE FROM tb_carrinho_itens WHERE id_carrinho = %s and id_filme = %s"
            cursor.execute(sql_insert, (id_carrinho, id_filme))
            conexao.commit()

            return True
            
        except Exception as e:
            print(e)
            return False

        finally:
            cursor.close()
            conexao.close()

    def exibirItens(id_usuario):

        conexao = Connection.create()
        cursor = conexao.cursor(dictionary=True)

        try:

            sql = """SELECT
                c.id_usuario, ci.id_filme, ci.quantidade, ci.preco, f.nome_filme, f.preco,
                i.img_1
                FROM tb_carrinho c
                INNER JOIN tb_carrinho_itens ci ON ci.id_carrinho = c.id_carrinho 
                INNER JOIN tb_filmes f ON ci.id_filme = f.id_filme
                INNER JOIN tb_fotos i on f.id_filme = i.id_filme
                where c.id_usuario = %s;
            """

            cursor.execute(sql, (id_usuario,))
            filmes = cursor.fetchall()

            if not filmes:
                return []
            return filmes
        
        except Exception as e:
            print(f"Erro ao buscar itens no carrinho {id_usuario}", e)
            return []
        
        finally:
            cursor.close()
            conexao.close()

    def teste(id_carrinho):

        conexao = Connection.create()
        cursor = conexao.cursor(dictionary=True)

        try:

            sql = """SELECT
                ci.id_filme, ci.quantidade, ci.preco, f.nome_filme
                FROM tb_carrinho_itens ci
                JOIN tb_filmes f ON ci.id_filme = f.id_filme
                where ci.id_carrinho = %s
            """

            cursor.execute(sql, (id_carrinho,))
            filmes = cursor.fetchall()  
        
        finally:
            cursor.close()
            conexao.close()
              
