from flask import Flask, request, render_template, redirect, session
from hashlib import sha256
from model.controller_usuario import Usuario
from model.controller_filmes import Filme
from model.controller_carrinho import Carrinho

app = Flask(__name__)

@app.route("/")
def pag_inicial():
    return render_template('index.html')

@app.route("/cadastro")
def pag_cadastro():
    return render_template('cadastro.html')

@app.route("/cadastrar/usuario", methods=["POST"])
def cadastrar_usuario():
    nome = request.form.get('nome')
    usuario = request.form.get('usuario')
    email = request.form.get('email')
    telefone = request.form.get('telefone')
    senha = request.form.get('senha')
    check = Usuario.cadastrar(nome,usuario,email,telefone,senha)
    if check:
        return redirect("/")
    else:
        return redirect("/cadastro")
    
@app.route("/login")
def pag_login():
    return render_template('login.html')

@app.route("/catalogo")
def pag_catalogo():
    filmes = Filme.exibirTodos()
    return render_template('catalogo.html', filmes = filmes)

@app.route("/filme/<id>")
def pag_filme(id):
    filme = Filme.exibir(id)
    return render_template('produto.html', filme = filme)

@app.route("/add/carrinho/<id>")
def add_carrinho(id):
    Carrinho.add(id, session[id])
    return redirect("/catalogo")

app.run(debug=True)