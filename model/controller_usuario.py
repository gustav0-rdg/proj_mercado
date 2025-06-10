from data.conexao import Connection
from hashlib import sha256
from flask import session

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

            sql = "INSERT INTO tb_usuarios(nome_usuario,usuario,email,telefone,senha) VALUES(%s,%s,%s,%s,%s)"
            cursor.execute(sql, (nome,usuario,email,telefone,senha))
            conexao.commit()
            return True
        
        except Exception as e:
            print(e)
            return False
        
        finally:
            conexao.close()

    def login(usuario, senha):

        senha = sha256(str(senha).encode()).hexdigest()

        conexao = Connection.create()
        cursor = conexao.cursor(dictionary=True)

        try:

            sql = "SELECT * FROM tb_usuario WHERE BINARY usuario = %s and BINARY senha = %s"
            cursor.execute(sql, (usuario, senha))
            newUser = cursor.fetchone()

            if newUser:
                # Preenchendo a session com as infos do usuário
                session['id_usuario'] = newUser['id_usuario']
                session['usuario'] = newUser['usuario']
                session['nome'] = newUser['nome_usuario']
                return True
            
            else:
                return False
            
        except Exception as e:
            print(e)
            
        finally:
            conexao.close()

    def logoff():
        session.clear()