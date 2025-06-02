from flask import Flask, request, render_template, redirect, session
from hashlib import sha256
from model.controller_usuario import Usuario
from model.controller_filmes import Filme
from model.controller_carrinho import Carrinho
from model.controller_comentarios import Comentarios

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
    categorias = Filme.categorias()
    filmes = Filme.exibirTodos()
    return render_template('catalogo.html', filmes = filmes, categorias = categorias)

@app.route("/filme/<id>", methods=["GET", "POST"])
def pag_filme(id):
    filme = Filme.exibir(id)
    comentarios = Comentarios.exibir()

    if request.method == "POST":
        avaliacao = request.form.get('placeholder')
        comentario = request.form.get('placeholder')

        resultado = Comentarios.add(id, session['id_usuario'],avaliacao, comentario)

        if resultado == True:
            return redirect(f"/filme/{id}")
        else:
            print(f"Erro ao adicionar o comentário no filme de ID: {id}")
            return redirect(f"/filme/{id}")

    return render_template('produto.html', filme = filme, comentarios = comentarios)
    


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
    if filmes == []:
        return redirect("/catalogo")
    return render_template('catalogo.html', filmes = filmes)

app.run(debug=True)