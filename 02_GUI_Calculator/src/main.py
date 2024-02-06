import tkinter as tk

class Calculator(tk.Tk):
    def __init__(self):
        super().__init__()

        self.title("Calculator")
        self.geometry("400x600")
        self.expression = ""

        self.create_widgets()

    def char_insert(self, number):
        self.display.insert(tk.END, number)
        self.expression += str(number)
        print(self.expression)

    def clear(self):
        self.display.delete(0, tk.END)
        self.expression = ""
        print(self.expression)

    def calculate(self):
        ans = eval(self.expression)
        self.display.delete(0, tk.END)
        self.display.insert(tk.END, ans)
        print(self.expression, ans)
        self.expression = str(ans)



    def create_widgets(self):
        self.display = tk.Entry(self, font=("Arial", 24))
        self.display.grid(row=0, column=0, columnspan=4)
        self.button1 = tk.Button(self, text="1", font=("Arial", 24), command=lambda: self.char_insert(1))
        self.button1.grid(row=1, column=0, padx=0, pady=0)
        self.button2 = tk.Button(self, text="2", font=("Arial", 24), command=lambda: self.char_insert(2))
        self.button2.grid(row=1, column=1, padx=2, pady=2)
        self.button3 = tk.Button(self, text="3", font=("Arial", 24), command=lambda: self.char_insert(3))
        self.button3.grid(row=1, column=2, padx=2, pady=2)
        self.button4 = tk.Button(self, text="4", font=("Arial", 24), command=lambda: self.char_insert(4))
        self.button4.grid(row=2, column=0, padx=2, pady=2)
        self.button5 = tk.Button(self, text="5", font=("Arial", 24), command=lambda: self.char_insert(5))
        self.button5.grid(row=2, column=1, padx=2, pady=2)
        self.button6 = tk.Button(self, text="6", font=("Arial", 24),command=lambda: self.char_insert(6))
        self.button6.grid(row=2, column=2, padx=2, pady=2)
        self.button7 = tk.Button(self, text="7", font=("Arial", 24), command=lambda: self.char_insert(7))
        self.button7.grid(row=3, column=0, padx=2, pady=2)
        self.button8 = tk.Button(self, text="8", font=("Arial", 24), command=lambda: self.char_insert(8))
        self.button8.grid(row=3, column=1, padx=2, pady=2)
        self.button9 = tk.Button(self, text="9", font=("Arial", 24), command=lambda: self.char_insert(9))
        self.button9.grid(row=3, column=2, padx=2, pady=2)
        self.button0 = tk.Button(self, text="0", font=("Arial", 24), command=lambda: self.char_insert(0))
        self.button0.grid(row=4, column=1, padx=2, pady=2)
        self.button_plus = tk.Button(self, text="+", font=("Arial", 24), command=lambda: self.char_insert("+"))
        self.button_plus.grid(row=2, column=3, padx=2, pady=2)
        self.button_minus = tk.Button(self, text="-", font=("Arial", 24), command=lambda: self.char_insert("-"))
        self.button_minus.grid(row=3, column=3, padx=2, pady=2)
        self.button_multiply = tk.Button(self, text="*", font=("Arial", 24), command=lambda: self.char_insert("*"))
        self.button_multiply.grid(row=4, column=0, padx=2, pady=2)
        self.button_divide = tk.Button(self, text="/", font=("Arial", 24), command=lambda: self.char_insert("/"))
        self.button_divide.grid(row=4, column=3, padx=2, pady=2)
        self.button_equals = tk.Button(self, text="=", font=("Arial", 24), command=self.calculate)
        self.button_equals.grid(row=4, column=2, padx=2, pady=2)
        self.button_clear = tk.Button(self, text="C", font=("Arial", 24), command=self.clear)
        self.button_clear.grid(row=1, column=3, padx=2, pady=2)





if __name__ == "__main__":
    app = Calculator()
    app.mainloop()
