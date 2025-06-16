from data.conexao import Connection

class Enderecos:
    def add(id_user, cep, cidade, logradouro, bairro, estado):
        conexao = Connection.create()
        cursor = conexao.cursor()
        try:
            cursor.execute("INSERT INTO tb_enderecos(id_usuario,cep,cidade,logradouro,bairro,estado)VALUES(%s,%s,%s,%s,%s,%s)", (id_user, cep, cidade, logradouro, bairro, estado))
            conexao.commit()
        except Exception as e:
            print(e)
        finally:
            conexao.close()

    def exibir(id_user):
        conexao = Connection.create()
        cursor = conexao.cursor(dictionary=True)
        try:
            cursor.execute("select * from tb_enderecos where id_usuario = %s", (id_user,))
            resultado = cursor.fetchone()
            if resultado:
                return resultado
            else:
                return []
        except Exception as e:
            print(e)
        finally: 
            conexao.close()