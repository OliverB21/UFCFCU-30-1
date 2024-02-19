import tkinter as tk
import datetime

class Calculator(tk.Tk):
    def __init__(self):
        super().__init__()

        self.title("Calculator")
        self.geometry("310x425")
        self.expression = ""

        self.create_widgets()

    def char_insert(self, number):
        self.display.insert(tk.END, number)
        self.expression += str(number)

    def clear(self):
        self.display.delete(0, tk.END)
        self.expression = ""

    def backspace(self):
        self.expression = self.expression[:-1]
        self.display.delete(len(self.expression), tk.END)


    def calculate(self):
        if "√" in self.expression:
            self.expression = self.expression.replace("√", "**0.5")
        if "^" in self.expression:
            self.expression = self.expression.replace("^", "**")
        if "%" in self.expression:
            self.expression = self.expression.replace("%", "/100*")

        try:
            ans = eval(self.expression)
            if ans == int(ans):
                ans = int(ans)
            self.display.delete(0, tk.END)
            self.display.insert(tk.END, ans)
            self.add_to_history(self.expression, ans)
            self.expression = str(ans)
        except ZeroDivisionError:
            self.display.delete(0, tk.END)
            self.display.insert(tk.END, "Error - Likely Division by Zero")
            self.expression = "Division by Zero"
        except SyntaxError:
            self.display.delete(0, tk.END)
            self.display.insert(tk.END, "Error - Invalid Expression")
            self.expression = "Invalid Expression"
        

    def add_to_history(self, expression, answer):
        with open("history.csv", "a") as file:
            file.write(f"{datetime.datetime.now()},{expression},{answer}")
            file.write("\n")
        
    def get_last_answer(self):
        with open("history.csv", "r") as file:
            lines = file.readlines()
            last_line = lines[-1]
            time, expression, answer = last_line.split(",")
            time, expression, answer = time.strip(), expression.strip(), answer.strip()
            print(f"Time: {time}, Expression: {expression}, Answer: {answer}")
            self.display.insert(tk.END, answer)
            self.expression += answer
    
    def return_all_history(self):
        with open("history.csv", "r") as file:
            lines = file.readlines()
            for line in lines:
                time, expression, answer = line.split(",")
                time, expression, answer = time.strip(), expression.strip(), answer.strip()
                print(f"Time: {time}, Expression: {expression}, Answer: {answer}")


    def create_widgets(self):
        self.display = tk.Entry(self, font=("Arial", 20), justify="right")
        self.display.bind("<Key>", lambda e: "break")
        self.display.grid(row=0, column=0, columnspan=5)
        self.button1 = tk.Button(self, text="1", font=("Arial", 24), command=lambda: self.char_insert(1))
        self.button1.grid(row=4, column=0, padx=0, pady=0)
        self.button2 = tk.Button(self, text="2", font=("Arial", 24), command=lambda: self.char_insert(2))
        self.button2.grid(row=4, column=1, padx=2, pady=2)
        self.button3 = tk.Button(self, text="3", font=("Arial", 24), command=lambda: self.char_insert(3))
        self.button3.grid(row=4, column=2, padx=2, pady=2)
        self.button4 = tk.Button(self, text="4", font=("Arial", 24), command=lambda: self.char_insert(4))
        self.button4.grid(row=3, column=0, padx=2, pady=2)
        self.button5 = tk.Button(self, text="5", font=("Arial", 24), command=lambda: self.char_insert(5))
        self.button5.grid(row=3, column=1, padx=2, pady=2)
        self.button6 = tk.Button(self, text="6", font=("Arial", 24),command=lambda: self.char_insert(6))
        self.button6.grid(row=3, column=2, padx=2, pady=2)
        self.button7 = tk.Button(self, text="7", font=("Arial", 24), command=lambda: self.char_insert(7))
        self.button7.grid(row=2, column=0, padx=2, pady=2)
        self.button8 = tk.Button(self, text="8", font=("Arial", 24), command=lambda: self.char_insert(8))
        self.button8.grid(row=2, column=1, padx=2, pady=2)
        self.button9 = tk.Button(self, text="9", font=("Arial", 24), command=lambda: self.char_insert(9))
        self.button9.grid(row=2, column=2, padx=2, pady=2)
        self.button0 = tk.Button(self, text="0", font=("Arial", 24), command=lambda: self.char_insert(0))
        self.button0.grid(row=5, column=1, padx=2, pady=2)
        self.button_plus = tk.Button(self, text="+", font=("Arial", 24), command=lambda: self.char_insert("+"))
        self.button_plus.grid(row=5, column=3, padx=2, pady=2)
        self.button_minus = tk.Button(self, text="-", font=("Arial", 24), command=lambda: self.char_insert("-"))
        self.button_minus.grid(row=4, column=3, padx=2, pady=2)
        self.button_multiply = tk.Button(self, text="*", font=("Arial", 24), command=lambda: self.char_insert("*"))
        self.button_multiply.grid(row=3, column=3, padx=2, pady=2)
        self.button_divide = tk.Button(self, text="/", font=("Arial", 24), command=lambda: self.char_insert("/"))
        self.button_divide.grid(row=2, column=3, padx=2, pady=2)
        self.button_left_bracket = tk.Button(self, text="(", font=("Arial", 24), command=lambda: self.char_insert("("))
        self.button_left_bracket.grid(row=6, column=0, padx=2, pady=2)
        self.button_right_bracket = tk.Button(self, text=")", font=("Arial", 24), command=lambda: self.char_insert(")"))
        self.button_right_bracket.grid(row=6, column=1, padx=2, pady=2)
        self.button_square_root = tk.Button(self, text="√", font=("Arial", 24), command=lambda: self.char_insert("√"))
        self.button_square_root.grid(row=5, column=0, padx=2, pady=2)
        self.button_power = tk.Button(self, text="^", font=("Arial", 24), command=lambda: self.char_insert("^"))
        self.button_power.grid(row=1, column=1, padx=2, pady=2)
        self.button_percent = tk.Button(self, text="%", font=("Arial", 24), command=lambda: self.char_insert("%"))
        self.button_percent.grid(row=1, column=0, padx=2, pady=2)
        self.button_dot = tk.Button(self, text=".", font=("Arial", 24), command=lambda: self.char_insert("."))
        self.button_dot.grid(row=5, column=2, padx=2, pady=2)
        self.button_equals = tk.Button(self, text="=", font=("Arial", 24), command=self.calculate)
        self.button_equals.grid(row=6, column=3, padx=2, pady=2)
        self.button_clear = tk.Button(self, text="C", font=("Arial", 24), command=self.clear)
        self.button_clear.grid(row=1, column=2, padx=2, pady=2)
        self.button_backspace = tk.Button(self, text="←", font=("Arial", 24), command=self.backspace)
        self.button_backspace.grid(row=1, column=3, padx=2, pady=2)
        self.button_previous = tk.Button(self, text="ANS", font=("Arial", 24), command=self.get_last_answer)
        self.button_previous.grid(row=6, column=2, padx=2, pady=2)
        self.button_history = tk.Button(self, text="⤾", font=("Arial", 24), command=self.return_all_history)
        self.button_history.grid(row=7, column=3, padx=2, pady=2)


if __name__ == "__main__":
    app = Calculator()
    app.mainloop()
