#region Importações
from flask import Flask, request, render_template, redirect, session, jsonify
from hashlib import sha256
from model.controller_usuario import Usuario
from model.controller_filmes import Filme
from model.controller_carrinho import Carrinho
from model.controller_comentarios import Comentarios
from model.controller_destaques import Destaques


app = Flask(__name__)
app.secret_key = "godofredomeuheroi"
@app.route("/")
def pag_inicial():
    destaque = Destaques.exibir_destaque()
    bem_avaliados = Destaques.exibir_melhores()
    return render_template('index.html', destaque = destaque, filmes=bem_avaliados)

#region Página de cadastro e funcionalidades
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
#endregion  
  
@app.route("/login")
def pag_login():
    return render_template('login.html')

@app.route("/login/usuario", methods=["POST"])
def logar_user():
    usuario = request.form.get('usuario')
    senha = request.form.get('senha')
    Usuario.login(usuario, senha)
    return redirect("/")

@app.route("/catalogo")
def pag_catalogo():
    categorias = Filme.categorias()
    filmes = Filme.exibirTodos()
    return render_template('catalogo.html', filmes = filmes, categorias = categorias, categoria_atual="todas")

@app.route("/filme/<id>", methods=["GET"])
def pag_filme(id):
    comentarios = Comentarios.exibir(id)
    filme = Filme.exibir(id)        
    return render_template('produto.html', filme = filme, comentarios = comentarios)

@app.route("/carrinho")
def pag_carrinho():
    if 'id_usuario' not in session:
        return redirect("/login")
    itens = Carrinho.exibirItens(session['id_usuario'])
    return jsonify(itens)

@app.route("/add/comentario/<id>", methods=["POST"])
def add_comentario(id):
    avaliacao = request.form.get('avaliacao')
    comentario = request.form.get('comentario')
    resultado = Comentarios.add(id, session['id_usuario'],avaliacao, comentario)
    if resultado == True:
        return redirect(f"/filme/{id}")
    else:
        print(f"Erro ao adicionar o comentário no filme de ID: {id}")
        return redirect(f"/filme/{id}")

@app.route("/add/carrinho/<id>")
def add_carrinho(id):
    Carrinho.add(id, session['id_usuario']) 
    return redirect("/catalogo")

@app.route("/remove/carrinho/<id>")
def remove_carrinho(id):
    Carrinho.remove(id, session['id_usuario'])
    return redirect("/catalogo")

@app.route("/filmes/exibir/<id>")
def exibir_filmesCat(id):
    filmes = Filme.exibirCategoria(id)
    categorias = Filme.categorias()
    if filmes == []:
        return redirect("/catalogo")
    return render_template('catalogo.html', filmes = filmes, categorias = categorias)

app.run(debug=True)