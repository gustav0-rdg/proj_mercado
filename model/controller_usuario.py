from data.conexao import Connection
from hashlib import sha256
class Usuario:
    def cadastrar(nome, usuario, email, telefone, senha):
        # Validando o email e a senha
        if email == '':
            email = None;
        if telefone == '':
            telefone = None
        senha = sha256(str(senha).encode()).hexdigest()
        conexao = Connection.create()
        cursor = conexao.cursor()
        try:    
            sql = "INSERT INTO tb_usuario(nome_usuario,usuario,email,telefone,senha) VALUES(%s,%s,%s,%s,%s)"
            cursor.execute(sql, (nome,usuario,email,telefone,senha))
            conexao.commit()
        except Exception as e:
            print(e)
        finally:
            conexao.close()