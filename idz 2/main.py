# This is a sample Python script.
import math
import os
import subprocess


# Press Shift+F10 to execute it or replace it with your code.
# Press Double Shift to search everywhere for classes, files, tool windows, actions, and settings.
def get_last_line(input_string):
    lines = input_string.split('\n')
    if lines:
        return lines[-1]
    else:
        return ""

def open(rars_path, paths, data):
    space = 66
    try:
        for input_int in data:
            input = str(input_int);
            result = subprocess.run(["java", "-jar", rars_path]+paths, input=input, text=True, capture_output=True)
            string = result.stdout[space:]
            print("-------------------------------------")
            print("Ввод:\n " + input)
            print("Вывод:\n" + string)

    except subprocess.CalledProcessError as e:
        print("Произошла ошибка:", e)

# Press the green button in the gutter to run the script.
def test_prog():

    rars_path = "rars1_6.jar"
    paths = ["main.asm", "calc_cos.s", "calculate_vector.s",
            "get_length.s", "input.s", "macrolib.s",
            "output.s", "prog.s"]


    data_correct = ["-1\n0\n0\n1\n1\n0\n0\n-1\n", "0\n0\n3\n3\n4\n0\n3\n-1\n", "-1\n3\n1\n3\n1\n-3\n-1\n-3\n",
            "0\n0\n1\n0\n1\n1\n0\n1\n", "-1\n2\n1\n2\n5\n-5\n-5\n-5\n"]
    data_incorrect = ["0\n0\n1\n1\n0\n1\n3\n0\n", "0\n0\n5\n4\n0\n8\n-5\n4\n", "0\n0\n5\n4\n0\n8\n-5\n4\n"]


    if not os.path.exists(rars_path):
        print("Ошибка: Файл rars.jar не найден в текущем каталоге.")
        return
    print('Верные данные')
    open(rars_path, paths, data_correct)
    print('Неверные данные')
    open(rars_path, paths, data_incorrect)
    pass


if __name__ == '__main__':
    test_prog()

# See PyCharm help at https://www.jetbrains.com/help/pycharm/
