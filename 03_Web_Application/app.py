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

def getFormResultsA():
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

def getFormResultsB():
    return [
        request.form['id'],
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

@app.route('/confirm-delete/<id>')
def confirmDelete(id):
    return render_template('confirm-delete.html', id=id)

@app.route('/edit', methods=['POST'])
def edit():
    results = getFormResultsB()
    with engine.connect() as connection:
        connection.execute(f'UPDATE invoices SET invoiceNumber={results[1]}, custName="{results[2]}", custAddress="{results[3]}", invoiceDate="{results[4]}", invoiceTotal={results[5]}, invoiceCurrency="{results[6]}", invoiceDescription="{results[7]}" WHERE id={results[0]}')
        return render_template('edit.html')


@app.route('/confirm-edit/<id>')
def confirmEdit(id):
    with engine.connect() as connection:
        result = connection.execute(f'SELECT * FROM invoices WHERE id={id}')
        invoice = result.fetchone()
        invoiceNumber, custName, custAddress, invoiceDate, invoiceTotal, invoiceCurrency, invoiceDescription=invoice[1], invoice[2], invoice[3], invoice[4], invoice[5], invoice[6], invoice[7]
        return render_template('confirm-edit.html', invoiceNumber=invoiceNumber, custName=custName, custAddress=custAddress, invoiceDate=invoiceDate, invoiceTotal=invoiceTotal, invoiceCurrency=invoiceCurrency, invoiceDescription=invoiceDescription, id=id)

@app.route('/submit', methods=['POST'])
def submit():
    formResults = getFormResultsA()
    with engine.connect() as connection:
        connection.execute(f'INSERT INTO invoices (invoiceNumber, custName, custAddress, invoiceDate, invoiceTotal, invoiceCurrency, invoiceDescription) VALUES ({formResults[0]}, "{formResults[1]}", "{formResults[2]}", "{formResults[3]}", {formResults[4]}, "{formResults[5]}", "{formResults[6]}")')
    return render_template('submit.html')

@app.route('/delete/', methods=['POST'])
def delete():
    id = request.form['id']
    with engine.connect() as connection:
        connection.execute(f'DELETE FROM invoices WHERE id={id}')
    return render_template('delete.html')

@app.route('/view')
def view():
    return render_template('view.html', invoices=loadInvoicesFromDB())

if __name__ == '__main__':
    app.run(debug=True)