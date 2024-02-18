from flask import Flask, render_template, request
from database import engine
app = Flask(__name__)

def loadInvoicesFromDB():
    with engine.connect() as connection:
        result = connection.execute('SELECT * FROM invoices')
        invoices = []
        for row in result:
            invoices.append(row)
        return invoices

def getFormResults():
    print(request.form)
    return [
        request.form['invoiceNumber'],
        request.form['custName'],
        request.form['custAddress'],
        request.form['invoiceDate'],
        request.form['invoiceTotal'],
        request.form['invoiceCurrency'],
        request.form['invoiceDescription']
    ]

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/create')
def create():
    return render_template('create.html')

@app.route('/submit', methods=['POST'])
def submit():
    formResults = getFormResults()
    with engine.connect() as connection:
        connection.execute(f'INSERT INTO invoices (invoiceNumber, custName, custAddress, invoiceDate, invoiceTotal, invoiceCurrency, invoiceDescription) VALUES ({formResults[0]}, "{formResults[1]}", "{formResults[2]}", "{formResults[3]}", {formResults[4]}, "{formResults[5]}", "{formResults[6]}")')
    return render_template('submit.html')

@app.route('/view')
def view():
    return render_template('view.html', invoices=loadInvoicesFromDB())

if __name__ == '__main__':
    app.run(debug=True)