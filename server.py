from flask import Flask, render_template, request

app = Flask(__name__)

@app.route("/")
def halaman_login():
    return render_template("login.html")

@app.route("/proses-login", methods=["POST"])
def proses_login():
    user_input = request.form.get("username")
    pass_input = request.form.get("password")
    
    if user_input == "admin" and pass_input == "rahasia":
        return f"<h3>Login Sukses! Selamat bekerja, {user_input}.</h3> <a href='/kasir'>Masuk ke Menu Kasir</a>"
    else:
        return "<h3>Login Gagal! Username atau password salah.</h3> <a href='/'>Kembali ke Login</a>"

@app.route("/kasir")
def halaman_kasir():
    return render_template("kasir.html")

if __name__ == "__main__":
    app.run(debug=True, port=5000)
