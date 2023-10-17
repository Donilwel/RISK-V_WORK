import os
import subprocess

def run_file(file_path, input_data):
    spaces = 66
    for input in input_data:
        RES = subprocess.run([
            "java",
            "-jar",
            "rars.jar",
            file_path],
            input=input,
            text=True,
            capture_output=True)
        print("Входные данные: \n" + input)
        print(RES.stdout[spaces:])

def main():
    file_inp = "../../../../ihw1/idz1.asm"

    test_data = [
        "0\n",
        "1\n2\n",
        "-1\n",
        "60\n",
        "16\n",
        "6\n3\n5\n2\n5\n7\n8\n",
        "3\n4\n6\n2\n",
        "9\n-2\n3\n2\n4\n1\n2\n-10\n3\n7\n"
    ]
    run_file(file_inp, test_data)

if __name__ == "__main__":
    main()
