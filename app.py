from flask import Flask, render_template, request, redirect, url_for

app = Flask(__name__)

@app.route('/')
def home():
    return render_template('index.html')

@app.route('/procesar', methods=['POST'])
def procesar():
    marca = request.form['marca']
    modelo = request.form['modelo']
    año = request.form['año']
    # Aquí podrías agregar lógica para calcular una oferta, guardar en base de datos, etc.
    return render_template('confirmacion.html', marca=marca, modelo=modelo, año=año)

if __name__ == '__main__':
    app.run(debug=True)
