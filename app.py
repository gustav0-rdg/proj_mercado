from data.conexao import Conexao
from flask import Flask, request, render_template, redirect, session
from hashlib import sha256

app = Flask(__name__)

@app.route("/")
def pag_inicial():
    return render_template('index.html')

@app.route("/cadastro")
def pag_cadastro():
    return render_template('cadastro.html')

@app.route("/login")
def pag_login():
    return render_template('login.html')

app.run(debug=True)