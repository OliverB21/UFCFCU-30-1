from flask import Flask, render_template
app = Flask(__name__)

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/create')
def create():
    return render_template('create.html')

@app.route('/view')
def view():
    return render_template('view.html')

if __name__ == '__main__':
    app.run(debug=True)