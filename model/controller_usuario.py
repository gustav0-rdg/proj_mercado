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

    def login(usuario, email ,senha):

        senha = sha256(str(senha).encode()).hexdigest()

        conexao = Connection.create()
        cursor = conexao.cursor(dictionary=True)

        try:

            sql = """
            SELECT * FROM tb_usuarios 
            WHERE (BINARY usuario = %s AND BINARY senha = %s) 
            OR (BINARY email = %s AND BINARY senha = %s)
            """
            cursor.execute(sql, (usuario, senha, email, senha))
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

    def isAdm(userID):
        conexao = Connection.create()
        cursor = conexao.cursor(dictionary=True)

        try:

            sql = "SELECT * FROM tb_usuarios WHERE id_usuario = %s AND tipo_usuario = 'admin'"
            cursor.execute(sql,(userID,))
            rows_returned = cursor.fetchone()

            if (rows_returned >= 1):
                return True
            else:
                return False

        except Exception as e: 
            print(e)
            return False
        
        finally:
            cursor.close()
            conexao.close()

    def logoff():
        session.clear()