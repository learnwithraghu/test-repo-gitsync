from flask import Flask, jsonify
import os

app = Flask(__name__)

@app.route("/")
def list_files():
    # List all files in the current directory
    files = os.listdir(".")
    return jsonify(files)

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
