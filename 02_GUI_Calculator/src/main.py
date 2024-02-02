import tkinter as tk

class Calculator(tk.Tk):
    def __init__(self):
        super().__init__()

        self.title("Calculator")
        self.geometry("400x600")

        self.create_widgets()

    def create_widgets(self):
        self.display = tk.Entry(self, font=("Arial", 24))
        self.display.pack(padx=10, pady=10, fill="x")


if __name__ == "__main__":
    app = Calculator()
    app.mainloop()
